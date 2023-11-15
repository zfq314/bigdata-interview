package zfq.bigdata.flink.api;

import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import zfq.bigdata.flink.bean.WaterSensor;

/**
 * @ClassName TransAggregation
 * @Description TODO 如果是pojo的时候，key不能按照位置，必须按照字段名称
 * @Author ZFQ
 * @Date 2023/11/15 17:23
 * @Version 1.0
 */
public class TransAggregation {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor_1", 1L, 1),
                new WaterSensor("sensor_1", 2L, 2),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        );
        waterSensorDataStreamSource.keyBy(data -> data.id).max("vc").print();
        env.execute();
    }
}