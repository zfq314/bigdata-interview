package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.functions.FilterFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName TransFilter
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 11:22
 * @Version 1.0
 */
public class TransFilter {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor_1", 1L, 1),
                new WaterSensor("sensor_1", 2L, 2),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        );

        waterSensorDataStreamSource.filter(data -> (data.id.equals("sensor_1"))).print("原始");

        //匿名内部类
        waterSensorDataStreamSource.filter(new FilterFunction<WaterSensor>() {
            @Override
            public boolean filter(WaterSensor value) throws Exception {
                return value.id.equals("sensor_1");
            }
        }).print("匿名");
        //实现类
        waterSensorDataStreamSource.filter(new MyFilterFunction()).print("实现类");
        env.execute();
    }

    private static class MyFilterFunction implements FilterFunction<WaterSensor> {
        @Override
        public boolean filter(WaterSensor value) throws Exception {
            return value.id.equals("sensor_1");
        }
    }
}