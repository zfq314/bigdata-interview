package zfq.bigdata.flink.api;

import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.Collector;
import zfq.bigdata.flink.bean.WaterSensor;

/**
 * @ClassName TransFlatmap
 * @Description TODO TransFlatmap
 * @Author ZFQ
 * @Date 2023/11/9 17:02
 * @Version 1.0
 */
public class TransFlatmap {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor_1", 1L, 1),
                new WaterSensor("sensor_1", 2L, 2),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        );
        waterSensorDataStreamSource.flatMap(new MyTransFlatmap()).print();
        env.execute();
    }

    private static class MyTransFlatmap implements FlatMapFunction<WaterSensor, String> {
        @Override
        public void flatMap(WaterSensor value, Collector<String> out) throws Exception {
            if (value.id.equals("sensor_1")) {
                out.collect(String.valueOf("sensor_1->vc:"+value.vc));
            } else if (value.id.equals("sensor_2")) {
                out.collect(String.valueOf("sensor_2->ts:"+value.ts));
                out.collect(String.valueOf("sensor_2->vc:"+value.vc));
            }
        }
    }
}