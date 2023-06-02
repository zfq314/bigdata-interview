package zfq.bigdata.interview.flink.chapter7;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.windowing.ProcessAllWindowFunction;
import org.apache.flink.streaming.api.windowing.assigners.SlidingEventTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;
import java.util.*;

/**
 * @ClassName ProcessAllWindowTopNDemo
 * @Description TODO 应用案例——Top N
 * @Author ZFQ
 * @Date 2023/6/2 11:44
 * @Version 1.0
 */
public class ProcessAllWindowTopNDemo {
    public static void main(String[] args) throws Exception {
        //例如，统计最近10秒钟内出现次数最多的两个水位，并且每5秒钟更新一次。我们知道，这可以用一个滑动窗口来实现。
        //于是就需要开滑动窗口收集传感器的数据，按照不同的水位进行统计，而后汇总排序并最终输出前两名。这其实就是著名的“Top N”问题。

        //思路一：一种最简单的想法是，我们干脆不区分不同水位，而是将所有访问数据都收集起来，统一进行统计计算。所以可以不做keyBy，直接基于DataStream开窗，
        // 然后使用全窗口函数ProcessAllWindowFunction来进行处理。
        //在窗口中可以用一个HashMap来保存每个水位的出现次数，只要遍历窗口中的所有数据，自然就能得到所有水位的出现次数。最后把HashMap转成一个列表ArrayList，然后进行排序、取出前两名输出就可以了
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        env.setParallelism(1);


        SingleOutputStreamOperator<WaterSensor> inputStream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(
                        WatermarkStrategy
                                .<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(5))
                                .withTimestampAssigner((data, ts) -> data.getTs() * 1000L)

                );
        // 最近10秒= 窗口长度， 每5秒输出 = 滑动步长
        // TODO 思路一： 所有数据到一起， 用hashmap存， key=vc，value=count值
        inputStream.windowAll(SlidingEventTimeWindows.of(Time.seconds(10), Time.seconds(5)))
                .process(new MyTopNPAWF())
                .print();


        env.execute();
    }

    public static class MyTopNPAWF extends ProcessAllWindowFunction<WaterSensor, String, TimeWindow> {
        @Override
        public void process(Context context, Iterable<WaterSensor> elements, Collector<String> out) throws Exception {
            //定义一个hashmap用来存key=vc,value=count值
            Map<Integer, Integer> map = new HashMap<>();
            for (WaterSensor element : elements) {
                Integer vc = element.getVc();
                if (map.containsKey(vc)) {
                    //key 存在，不是这个key的第一条数据直接累加
                    map.put(vc, map.get(vc) + 1);
                } else {
                    //key不存在初始化
                    map.put(vc, 1);
                }
            }
            //对count值进行排序，利用List来实现排序
            List<Tuple2<Integer, Integer>> datas = new ArrayList<>();
            for (Integer vc : map.keySet()) {
                datas.add(Tuple2.of(vc, map.get(vc)));
            }
            //对list进行排序，根据count排序
            datas.sort(
                    new Comparator<Tuple2<Integer, Integer>>() {
                        @Override
                        public int compare(Tuple2<Integer, Integer> o1, Tuple2<Integer, Integer> o2) {
                            // 降序 后减前
                            return o2.f1 - o1.f1;

                        }
                    }
            );
            //取出count最大的2个值
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("================================\n");
            // 遍历 排序后的 List，取出前2个， 考虑可能List不够2个的情况  ==》 List中元素的个数 和 2 取最小值
            for (int i = 0; i < Math.min(2, datas.size()); i++) {
                Tuple2<Integer, Integer> vcCount = datas.get(i);
                stringBuilder.append("Top" + (i + 1) + "\n");
                stringBuilder.append("vc=" + vcCount.f0 + "\n");
                stringBuilder.append("count=" + vcCount.f1 + "\n");
                stringBuilder.append("窗口结束时间=" + DateFormatUtils.format(context.window().getEnd(), "yyyy-MM-dd HH:mm:ss.SSS") + "\n");
                stringBuilder.append("================================\n");
            }
            out.collect(stringBuilder.toString());
        }
    }
}