package zfq.bigdata.flink.api;

import org.apache.flink.api.common.functions.FilterFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import zfq.bigdata.flink.bean.WaterSensor;

/**
 * @ClassName TransFunctionUDF
 * @Description TODO udf
 * @Author ZFQ
 * @Date 2023/11/15 17:42
 * @Version 1.0
 */
public class TransFunctionUDF {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor_1", 1L, 1),
                new WaterSensor("sensor_1", 2L, 2),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        );

        SingleOutputStreamOperator<WaterSensor> filter = waterSensorDataStreamSource.filter(new UserCustomFilter());
        waterSensorDataStreamSource.filter(new FilterFunction<WaterSensor>() {
            @Override
            public boolean filter(WaterSensor value) throws Exception {
                return value.id.equals("sensor_1");
            }
        }).print();
        filter.print();


        env.execute();
    }

    private static class UserCustomFilter implements FilterFunction<WaterSensor> {
        @Override
        public boolean filter(WaterSensor value) throws Exception {
            return value.id.equals("sensor_1");
        }
    }
}