package zfq.bigdata.interview.flink.chapter6;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.windowing.ProcessWindowFunction;
import org.apache.flink.streaming.api.windowing.assigners.TumblingEventTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;

/**
 * @ClassName WatermarkOutOfOrdernessDemo
 * @Description TODO 乱序流中内置水位线设置
 * @Author ZFQ
 * @Date 2023/5/30 17:58
 * @Version 1.0
 */
public class WatermarkOutOfOrdernessDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        env.setParallelism(1);
        //sensor,2,100
        //sensor,11,700
        //sensor,9,700
        //sensor,14,700
        //sensor,19,700
        //sensor,15,700
        //sensor,23,700
        //sensor,24,700
        //sensor,22,700
        //sensor,34,700
        //sensor,33,700
        SingleOutputStreamOperator<WaterSensor> stream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction());

        // TODO 1.定义Watermark策略
        // 1.1 指定watermark生成：乱序的，等待3s
        WatermarkStrategy<WaterSensor> waterSensorWatermarkStrategy = WatermarkStrategy.<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                // 1.2 指定 时间戳分配器，从数据中提取
                .withTimestampAssigner((element, recordTimestamp) -> {
                    //返回的时间戳要毫秒
                    System.out.println("数据=" + element + ",recordTs=" + recordTimestamp);
                    return element.getTs() * 1000L;
                });
        // TODO 2. 指定 watermark策略
        SingleOutputStreamOperator<WaterSensor> sensorWithWatermarkData = stream.assignTimestampsAndWatermarks(waterSensorWatermarkStrategy);
        sensorWithWatermarkData.keyBy(sensor -> sensor.getId())
                // TODO 3.使用 事件时间语义 的窗口
                .window(TumblingEventTimeWindows.of(Time.seconds(10)))
                .process(new ProcessWindowFunction<WaterSensor, String, String, TimeWindow>() {
                    @Override
                    public void process(String s, Context context, Iterable<WaterSensor> elements, Collector<String> out) throws Exception {
                        long start = context.window().getStart();
                        long end = context.window().getEnd();
                        String windowStart = DateFormatUtils.format(start, "yyyy-MM-dd HH:mm:ss.SSS");
                        String windowEnd = DateFormatUtils.format(end, "yyyy-MM-dd HH:mm:ss.SSS");

                        long count = elements.spliterator().estimateSize();
                        out.collect("key=" + s + "的窗口[" + windowStart + "," + windowEnd + ")包含" + count + "条数据===>" + elements.toString());
                    }
                }).print();


        env.execute();
    }
}