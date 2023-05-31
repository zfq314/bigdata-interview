package zfq.bigdata.interview.flink.chapter6;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.windowing.ProcessWindowFunction;
import org.apache.flink.streaming.api.windowing.assigners.TumblingEventTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
import org.apache.flink.util.Collector;
import org.apache.flink.util.OutputTag;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;

/**
 * @ClassName WatermarkLateDemo
 * @Description TODO
 * //TODO  forBoundedOutOfOrderness 最大延迟时间，eventTime-forBoundedOutOfOrderness 来判断窗口是否触发计算[
 * // TODO  窗口规则 左闭右开
 * //TODO   senser,2,11  2-3<10 不触发
 * //TODO   senser,6,11 6-3<10 不触发
 * // TODO  senser,3,11 3-3<10 不触发
 * //TODO  senser,10,11 10-3<10 不触发
 * //TODO  senser,13,11 13-3=10 触发计算 但是不关闭窗口 ，关闭窗口的时间，是当前的watermark+Allowedlateness,此时的watermark=13,+2 15,
 * //TODO  15的时候才会关闭，后面来的数据需要进侧输出流，进行数据的兜底操作 后面都是下个窗口
 * @Author ZFQ
 * @Date 2023/5/31 11:09
 * @Version 1.0
 */

public class WatermarkLateDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);
        SingleOutputStreamOperator<WaterSensor> inputStream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction());

        WatermarkStrategy<WaterSensor> waterSensorWatermarkStrategy = WatermarkStrategy.<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                .withTimestampAssigner((element, timestamp) -> element.getTs() * 1000L);

        SingleOutputStreamOperator<WaterSensor> waterSensorSingleOutputStreamOperatorWithWatermark = inputStream.assignTimestampsAndWatermarks(waterSensorWatermarkStrategy);
        //定义侧输出流
        OutputTag<WaterSensor> lateTag = new OutputTag<>("late-data", Types.POJO(WaterSensor.class));

        SingleOutputStreamOperator<String> process = waterSensorSingleOutputStreamOperatorWithWatermark.keyBy(sensor -> sensor.getId())
                .window(TumblingEventTimeWindows.of(Time.seconds(10)))
                .allowedLateness(Time.seconds(2))//允许迟到2s的数据
                .sideOutputLateData(lateTag)//关窗后的迟到的数据放侧输出流
                .process(new ProcessWindowFunction<WaterSensor, String, String, TimeWindow>() {
                    @Override
                    public void process(String s, Context context, Iterable<WaterSensor> elements, Collector<String> out) throws Exception {
                        long start = context.window().getStart();
                        long end = context.window().getEnd();
                        String windowStart = DateFormatUtils.format(start, "yyyy-MM-dd HH:mm:ss.SSS");
                        String windowEnd = DateFormatUtils.format(end, "yyyy-MM-dd HH:mm:ss.SSS");
                        long count = elements.spliterator().estimateSize();//数据

                        out.collect("key=" + s + "的窗口[" + windowStart + "," + windowEnd + ")包含" + count + "条数据===>" + elements.toString());
                    }
                });
        //senser,3,1
        //senser,1,1
        //senser,6,1
        //senser,3,1
        //senser,13,2
        //senser,2,1
        //senser,14,2
        //senser,15,2
        //senser,2,1
        //senser,21,3
        //senser,22,3
        //senser,23,2
        //senser,16,2
        //senser,12,4
        //senser,24,22
        //senser,25,3
        //senser,18,2
        process.print();
        process.getSideOutput(lateTag).printToErr("关窗后迟到的数据");
        env.execute();
        //forBoundedOutOfOrderness
        //定义 watermark 的时候可以设置生成 watermark 的时间比事件时间延迟多久，即 eventTime + maxoutoforderness

        //allowedLateness
        //定义开窗函数 的时候可以设置生成 allowedLateness，当前窗口在watermark满足 windowEndTime 的时候，
        // 在延迟 allowedLateness 时间之后再关闭，即知道 watermark 到了 windowEndTime + allowedLateness 之后，当前窗口才关闭。


        //1.MaxOutOfOrderness 作用于全局使用到事件事件的所有操作，包含定时器、窗口函数等。

        //2.Allowedlateness 只作用于事件事件的窗口函数，当 watermark通过窗口的终点时，一个事件时间窗口将被触发，在有一些允许的延迟的情况下，
        //该窗口将在每个延迟事件到达时再次触发，直到允许的延迟过期为止（此触发行为可以自定义——这是默认设置）。一旦允许的延迟过期，窗口的状态将被清除
        //，然后延迟事件要么被丢弃，要么被发送到一个侧面输出（如果配置了一个）。

        //senser,2,1
        //senser,1,3
        //senser,9,4
        //senser,10,1
        //senser,11,1
        //senser,12,1
        //senser,13,1
        //key=senser的窗口[1970-01-01 08:00:00.000,1970-01-01 08:00:10.000)包含3条数据===>[WaterSensor{id='senser', ts=2, vc=1},
        // WaterSensor{id='senser', ts=1, vc=3}, WaterSensor{id='senser', ts=9, vc=4}]

        //此时窗口还没关闭

        //windowEndTime=13 +2

        //senser,3,2 迟到数据
        //senser,6,7 迟到数据
        //senser,9,2 迟到数据
        //senser,14,2
        //senser,15,2
        //key=senser的窗口[1970-01-01 08:00:00.000,1970-01-01 08:00:10.000)包含6条数据===>[WaterSensor{id='senser', ts=2, vc=1},
        // WaterSensor{id='senser', ts=1, vc=3}, WaterSensor{id='senser', ts=9, vc=4}, WaterSensor{id='senser', ts=3, vc=2},
        // WaterSensor{id='senser', ts=6, vc=7}, WaterSensor{id='senser', ts=9, vc=2}]

        //senser,3,2 窗口已经关闭 迟到数据 关窗后迟到的数据> WaterSensor{id='senser', ts=3, vc=2}


    }
}