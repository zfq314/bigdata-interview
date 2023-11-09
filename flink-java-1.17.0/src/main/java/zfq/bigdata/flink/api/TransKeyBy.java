package zfq.bigdata.flink.api;

import org.apache.flink.api.java.functions.KeySelector;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import zfq.bigdata.flink.bean.WaterSensor;

/**
 * @ClassName TransKeyBy
 * @Description TODO TransKeyBy
 * @Author ZFQ
 * @Date 2023/11/9 17:25
 * @Version 1.0
 */
public class TransKeyBy {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor_1", 1L, 1),
                new WaterSensor("sensor_1", 2L, 2),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        );
        //lambda表达式
        waterSensorDataStreamSource.keyBy(key -> key.id);


        //匿名内部类
        waterSensorDataStreamSource.keyBy(new KeySelector<WaterSensor, String>() {
            @Override
            public String getKey(WaterSensor value) throws Exception {

                return value.id;
            }
        });

        env.execute();
    }
}