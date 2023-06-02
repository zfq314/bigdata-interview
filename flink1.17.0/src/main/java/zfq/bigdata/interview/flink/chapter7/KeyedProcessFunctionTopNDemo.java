package zfq.bigdata.interview.flink.chapter7;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.functions.AggregateFunction;
import org.apache.flink.api.java.tuple.Tuple3;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.KeyedProcessFunction;
import org.apache.flink.streaming.api.functions.windowing.ProcessWindowFunction;
import org.apache.flink.streaming.api.windowing.assigners.SlidingEventTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;
import java.util.*;

/**
 * @ClassName KeyedProcessFunctionTopNDemo
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/6/2 14:10
 * @Version 1.0
 */
//一是对数据进行按键分区，分别统计vc的出现次数；二是进行增量聚合，得到结果最后再做排序输出。
// 所以，我们可以使用增量聚合函数AggregateFunction进行浏览量的统计，然后结合ProcessWindowFunction排序输出来实现Top N的需求。
//具体实现可以分成两步：先对每个vc统计出现次数，然后再将统计结果收集起来，排序输出最终结果。由于最后的排序还是基于每个时间窗口的，
// 输出的统计结果中要包含窗口信息，我们可以输出包含了vc、出现次数（count）以及窗口结束时间的Tuple3。之后先按窗口结束时间分区，然后用KeyedProcessFunction来实现。
//用KeyedProcessFunction来收集数据做排序，这时面对的是窗口聚合之后的数据流，而窗口已经不存在了；我们需要确保能够收集齐所有数据，
// 所以应该在窗口结束时间基础上再“多等一会儿”。具体实现上，可以采用一个延迟触发的事件时间定时器。基于窗口的结束时间来设定延迟，
// 其实并不需要等太久——因为我们是靠水位线的推进来触发定时器，而水位线的含义就是“之前的数据都到齐了”。所以我们只需要设置1毫秒的延迟，就一定可以保证这一点。
//而在等待过程中，之前已经到达的数据应该缓存起来，我们这里用一个自定义的HashMap来进行存储，key为窗口的标记，value为List。之后每来一条数据，
// 就把它添加到当前的HashMap中，并注册一个触发时间为窗口结束时间加1毫秒（windowEnd + 1）的定时器。待到水位线到达这个时间，定时器触发，我们可以保证当前窗口所有vc的统计结果Tuple3都到齐了；
// 于是从HashMap中取出进行排序输出。
public class KeyedProcessFunctionTopNDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        SingleOutputStreamOperator<WaterSensor> sensorDataStream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(
                        WatermarkStrategy
                                .<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                                .withTimestampAssigner((record, ts) -> record.getTs() * 1000L)
                );


        // 最近10秒= 窗口长度， 每5秒输出 = 滑动步长
        /**
         * TODO 思路二： 使用 KeyedProcessFunction实现
         * 1、按照vc做keyby，开窗，分别count
         *    ==》 增量聚合，计算 count
         *    ==》 全窗口，对计算结果 count值封装 ，  带上 窗口结束时间的 标签
         *          ==》 为了让同一个窗口时间范围的计算结果到一起去
         *
         * 2、对同一个窗口范围的count值进行处理： 排序、取前N个
         *    =》 按照 windowEnd做keyby
         *    =》 使用process， 来一条调用一次，需要先存，分开存，用HashMap,key=windowEnd,value=List
         *      =》 使用定时器，对 存起来的结果 进行 排序、取前N个
         */

        // 1. 按照 vc 分组、开窗、聚合（增量计算+全量打标签）
        //  开窗聚合后，就是普通的流，没有了窗口信息，需要自己打上窗口的标记 windowEnd
        SingleOutputStreamOperator<Tuple3<Integer, Integer, Long>> windowAgg = sensorDataStream.keyBy(data -> data.getVc())
                .window(SlidingEventTimeWindows.of(Time.seconds(10), Time.seconds(5)))
                .aggregate(
                        new VcCountAgg(),
                        new WindowResult()
                );
        windowAgg.keyBy(data -> data.f2)
                .process(new TopN(2))
                .print();

        env.execute();
    }

    public static class VcCountAgg implements AggregateFunction<WaterSensor, Integer, Integer> {
        @Override
        public Integer createAccumulator() {
            return 0;
        }

        @Override
        public Integer add(WaterSensor value, Integer accumulator) {
            return accumulator + 1;
        }

        @Override
        public Integer getResult(Integer accumulator) {
            return accumulator;
        }

        @Override
        public Integer merge(Integer a, Integer b) {
            return null;
        }
    }

    /**
     * 泛型如下：
     * 第一个：输入类型 = 增量函数的输出  count值，Integer
     * 第二个：输出类型 = Tuple3(vc，count，windowEnd) ,带上 窗口结束时间 的标签
     * 第三个：key类型 ， vc，Integer
     * 第四个：窗口类型
     */
    public static class WindowResult extends ProcessWindowFunction<Integer, Tuple3<Integer, Integer, Long>, Integer, TimeWindow> {
        @Override
        public void process(Integer integer, Context context, Iterable<Integer> elements, Collector<Tuple3<Integer, Integer, Long>> out) throws Exception {
            // 迭代器里面只有一条数据，next一次即可
            Integer count = elements.iterator().next();
            long end = context.window().getEnd();
            out.collect(Tuple3.of(integer, count, end));
        }
    }

    public static class TopN extends KeyedProcessFunction<Long, Tuple3<Integer, Integer, Long>, String> {
        // 存不同窗口的 统计结果，key=windowEnd，value=list数据
        private Map<Long, List<Tuple3<Integer, Integer, Long>>> dataListMap;

        // 要取的Top数量
        private int threshold;

        public TopN(int threshold) {
            this.threshold = threshold;
            dataListMap = new HashMap<>();
        }

        @Override
        public void processElement(Tuple3<Integer, Integer, Long> value, Context ctx, Collector<String> out) throws Exception {
            // 进入这个方法，只是一条数据，要排序，得到齐才行 ===》 存起来，不同窗口分开存
            // 1. 存到HashMap中
            Long windowEnd = value.f2;
            if (dataListMap.containsKey(windowEnd)) {
                // 1.1 包含vc，不是该vc的第一条，直接添加到List中
                List<Tuple3<Integer, Integer, Long>> dataList = dataListMap.get(windowEnd);
                dataList.add(value);
            } else {
                // 1.1 不包含vc，是该vc的第一条，需要初始化list
                List<Tuple3<Integer, Integer, Long>> dataList = new ArrayList<>();
                dataList.add(value);
                dataListMap.put(windowEnd, dataList);
            }
            // 2. 注册一个定时器， windowEnd+1ms即可（
            // 同一个窗口范围，应该同时输出，只不过是一条一条调用processElement方法，只需要延迟1ms即可
            ctx.timerService().registerEventTimeTimer(windowEnd + 1);
            ;
        }

        @Override
        public void onTimer(long timestamp, OnTimerContext ctx, Collector<String> out) throws Exception {
            super.onTimer(timestamp, ctx, out);
            // 定时器触发，同一个窗口范围的计算结果攒齐了，开始 排序、取TopN
            Long windowEnd = ctx.getCurrentKey();
            // 1. 排序
            List<Tuple3<Integer, Integer, Long>> dataList = dataListMap.get(windowEnd);
            dataList.sort(new Comparator<Tuple3<Integer, Integer, Long>>() {
                @Override
                public int compare(Tuple3<Integer, Integer, Long> o1, Tuple3<Integer, Integer, Long> o2) {
                    // 降序， 后 减 前
                    return o2.f1 - o1.f1;
                }
            });
            // 2. 取TopN
            StringBuilder outStr = new StringBuilder();

            outStr.append("================================\n");
            // 遍历 排序后的 List，取出前 threshold 个， 考虑可能List不够2个的情况  ==》 List中元素的个数 和 2 取最小值
            for (int i = 0; i < Math.min(threshold, dataList.size()); i++) {
                Tuple3<Integer, Integer, Long> vcCount = dataList.get(i);
                outStr.append("Top" + (i + 1) + "\n");
                outStr.append("vc=" + vcCount.f0 + "\n");
                outStr.append("count=" + vcCount.f1 + "\n");
                outStr.append("窗口结束时间=" + vcCount.f2 + "\n");
                outStr.append("================================\n");
            }

            // 用完的List，及时清理，节省资源
            dataList.clear();

            out.collect(outStr.toString());
        }
    }
}