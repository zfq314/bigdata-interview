package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.java.functions.KeySelector;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.KeyedStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName TransKeyBy
 * @Description TODO TransKeyBy
 * @Author ZFQ
 * @Date 2023/5/25 14:29
 * @Version 1.0
 */
public class TransKeyBy {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor_1", 1L, 2),
                new WaterSensor("sensor_1", 2L, 3),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        );
        //Lambda表达式
        KeyedStream<WaterSensor, String> keyedStream = waterSensorDataStreamSource
                .keyBy(e -> e.id);
        keyedStream.sum("vc").print("sum");
        keyedStream.min("vc").print("min");
        //匿名内部类
        KeyedStream<WaterSensor, String> waterSensorStringKeyedStream = waterSensorDataStreamSource.keyBy(new KeySelector<WaterSensor, String>() {
            @Override
            public String getKey(WaterSensor value) throws Exception {
                return value.id;
            }
        });

         env.execute();
    }
}