package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.Collector;

/**
 * @ClassName TransFlatmap
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 11:31
 * @Version 1.0
 */
public class TransFlatmap {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor_1", 1L, 2),
                new WaterSensor("sensor_1", 2L, 3),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        );
        waterSensorDataStreamSource.flatMap(new MyFlatMapFunction()).print();
        env.execute();
    }

    //
    public static class MyFlatMapFunction implements FlatMapFunction<WaterSensor, String> {
        @Override
        public void flatMap(WaterSensor value, Collector<String> out) throws Exception {
            if (value.id.equals("sensor_1")) {
                out.collect(String.valueOf(value.vc));
            } else if (value.id.equals("sensor_3")) {
                out.collect(String.valueOf(value.ts));
                out.collect(String.valueOf(value.vc));
            }
        }
    }
}