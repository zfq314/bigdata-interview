package zfq.bigdata.flink.api;

import org.apache.flink.api.common.functions.FilterFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import zfq.bigdata.flink.bean.WaterSensor;

/**
 * @ClassName TransFilter
 * @Description TODO TransFilter
 * @Author ZFQ
 * @Date 2023/11/9 16:54
 * @Version 1.0
 */
public class TransFilter {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<WaterSensor> streamSensor = env.fromElements(
                new WaterSensor("sensor_1", 1L, 1),
                new WaterSensor("sensor_1", 2L, 2),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        );
        //内部类
        streamSensor.filter(new FilterFunction<WaterSensor>() {
            @Override
            public boolean filter(WaterSensor value) throws Exception {
                return value.id.equals("sensor_1");
            }
        }).print();

        //实现类
        streamSensor.filter(new MyFilter()).print();

        env.execute();
    }

    private static class MyFilter implements FilterFunction<WaterSensor> {
        @Override
        public boolean filter(WaterSensor value) throws Exception {
            return !(value.id.equals("sensor_1"));
        }
    }
}