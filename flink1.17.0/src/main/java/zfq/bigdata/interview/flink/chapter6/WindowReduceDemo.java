package zfq.bigdata.interview.flink.chapter6;

import org.apache.flink.api.common.functions.ReduceFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.windowing.assigners.TumblingProcessingTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

/**
 * @ClassName WindowReduceDemo
 * @Description TODO 归约函数（ReduceFunction）
 * @Author ZFQ
 * @Date 2023/5/29 17:45
 * @Version 1.0
 */
public class WindowReduceDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment().setParallelism(1);

        DataStreamSource<String> inputStreamData = env.socketTextStream("hadoop31", 7777);

        inputStreamData.map(new WaterSensorMapFunction())
                .keyBy(r -> r.id)
                //设置滚动事件时间窗口

                //滑动窗口处理时间 此处 处理时间而不是事件时间
                // sensor1,2,1000
                //sensor1,3,2000
                //sensor1,2,7000
                .window(TumblingProcessingTimeWindows.of(Time.seconds(5)))
                .reduce(new ReduceFunction<WaterSensor>() {
                    @Override
                    public WaterSensor reduce(WaterSensor value1, WaterSensor value2) throws Exception {
                        System.out.println("调用reduce方法，之前的结果:" + value1 + ",现在来的数据:" + value2);
                        return new WaterSensor(value1.getId(), System.currentTimeMillis(), value1.getVc() + value2.getVc());
                    }
                })
                .print()
        ;

        env.execute();
    }
}