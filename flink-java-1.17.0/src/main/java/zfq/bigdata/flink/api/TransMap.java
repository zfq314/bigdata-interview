package zfq.bigdata.flink.api;

import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import zfq.bigdata.flink.bean.WaterSensor;

/**
 * @ClassName TransMap
 * @Description TODO 转换算子map
 * @Author ZFQ
 * @Date 2023/11/9 16:47
 * @Version 1.0
 */
public class TransMap {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor2", 2L, 2),
                new WaterSensor("sensor3", 3L, 3)
        );

        //匿名内部类
        waterSensorDataStreamSource.map(new MapFunction<WaterSensor, String>() {
            @Override
            public String map(WaterSensor value) throws Exception {
                return value.id;
            }
        }).print("内部类");

        // 方式二：传入MapFunction的实现类
        waterSensorDataStreamSource.map(new MyMap()).print("myMap");


        env.execute();
    }

    private static class MyMap  implements MapFunction<WaterSensor,String >{
        @Override
        public String map(WaterSensor value) throws Exception {
            return value.id;
        }
    }
}