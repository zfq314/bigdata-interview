package zfq.bigdata.flink.api;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.windowing.ProcessWindowFunction;
import org.apache.flink.streaming.api.windowing.assigners.TumblingEventTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
import org.apache.flink.util.Collector;
import zfq.bigdata.flink.bean.WaterSensor;

import java.time.Duration;

/**
 * @ClassName WatermarkOutOfOrdernessDemo
 * @Description TODO 乱序事件处理机制
 * @Author ZFQ
 * @Date 2023/12/16 15:55
 * @Version 1.0
 */
public class WatermarkOutOfOrdernessDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        DataStreamSource<String> inputStream = env.socketTextStream("hadoop31", 7777);
        SingleOutputStreamOperator<WaterSensor> mapStream = inputStream.map(new WindowReduceDemo.WaterSensorMapFunction());
        // 1.定义Watermark策略
        // 1.1 指定watermark生成：乱序的，等待3s
        WatermarkStrategy.<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                // 1.2 指定 时间戳分配器，从数据中提取
                .withTimestampAssigner((element, recordTimestamp) -> {
                    System.out.println("数据=" + element + ",recordTs=" + recordTimestamp);
                    //返回的事件戳要毫秒
                    return element.getTs() * 1000L;
                });
        //指定watermark策略

        mapStream.keyBy(data -> data.getId())
                //使用事件时间语义的窗口
                .window(TumblingEventTimeWindows.of(Time.seconds(10)))
                .process(
                        new ProcessWindowFunction<WaterSensor, String, String, TimeWindow>() {
                            @Override
                            public void process(String s, Context context, Iterable<WaterSensor> elements, Collector<String> out) throws Exception {

                                long count = elements.spliterator().estimateSize();
                                long start = context.window().getStart();
                                long end = context.window().getEnd();
                                String windowStart = DateFormatUtils.format(start, "yyyy-MM-dd HH:mm:ss.SSS");
                                String windowEnd = DateFormatUtils.format(end, "yyyy-MM-dd HH:mm:ss.SSS");

                                out.collect("key=" + s + "的窗口[" + windowStart + "," + windowEnd + ")包含" + count + "条数据===>" + elements.toString());
                            }
                        }
                ).print();
        env.execute();
    }
}