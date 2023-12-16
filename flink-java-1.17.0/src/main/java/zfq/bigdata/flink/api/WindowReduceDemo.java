package zfq.bigdata.flink.api;

import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.common.functions.ReduceFunction;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.windowing.assigners.TumblingProcessingTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import zfq.bigdata.flink.bean.WaterSensor;

/**
 * @ClassName WindowReduceDemo
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/12/16 10:43
 * @Version 1.0
 */
public class WindowReduceDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .keyBy(r -> r.getId())
                //设置滚动事件时间窗口
                .window(
                        TumblingProcessingTimeWindows.of(Time.seconds(10))
                ).reduce(new ReduceFunction<WaterSensor>() {
            @Override
            public WaterSensor reduce(WaterSensor value1, WaterSensor value2) throws Exception {
                System.out.println("调用reduce方法，之前的结果:" + value1 + ",现在来的数据:" + value2);
                return new WaterSensor(value1.getId(), System.currentTimeMillis(), value1.getVc() + value2.getVc());
            }
        })
                .print();


        env.execute();
    }

    static class WaterSensorMapFunction implements MapFunction<String, WaterSensor> {
        @Override
        public WaterSensor map(String value) throws Exception {
            String[] datas = value.split(",");
            return new WaterSensor(datas[0], Long.valueOf(datas[1]), Integer.valueOf(datas[2]));
        }
    }
}