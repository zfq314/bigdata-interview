package zfq.bigdata.interview.flink.chapter6;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.windowing.ProcessWindowFunction;
import org.apache.flink.streaming.api.windowing.assigners.TumblingProcessingTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import org.apache.flink.streaming.api.windowing.windows.TimeWindow;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

/**
 * @ClassName WindowProcessDemo
 * @Description TODO WindowProcessDemo,全窗口函数
 * @Author ZFQ
 * @Date 2023/5/30 14:48
 * @Version 1.0
 */
public class WindowProcessDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        env.setParallelism(1);

        //sensor1,2,1000
        //sensor1,3,2000
        //sensor1,2,7000
        //单输出流操作
        SingleOutputStreamOperator<String> result
                = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .keyBy(sensor -> sensor.getId())
                //窗口分配器
                .window(TumblingProcessingTimeWindows.of(Time.seconds(10)))
                .process(new ProcessWindowFunction<WaterSensor, String, String, TimeWindow>() {
                    @Override
                    public void process(String s, Context context, Iterable<WaterSensor> elements, Collector<String> out) throws Exception {
                        long count = elements.spliterator().estimateSize();
                        long windowStartTs = context.window().getStart();
                        long windowEndTs = context.window().getEnd();
                        String windowStart = DateFormatUtils.format(windowStartTs, "yyyy-MM-dd HH:mm:ss.SSS");
                        String windowEnd = DateFormatUtils.format(windowEndTs, "yyyy-MM-dd HH:mm:ss.SSS");
                        out.collect("key=" + s + "的窗口[" + windowStart + "," + windowEnd + ")包含" + count + "条数据===>" + elements.toString());

                    }
                });
        result.print();
        env.execute();
    }
}