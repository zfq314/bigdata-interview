package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName TransMap
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 11:04
 * @Version 1.0
 */
public class TransMap {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<WaterSensor> waterSensorDataStreamSource = env.fromElements(
                new WaterSensor("sensor_1", 1L, 1),
                new WaterSensor("sensor_2", 2L, 2)
        );
        //传入匿名内部类实现MapFunction
        waterSensorDataStreamSource.map(new MapFunction<WaterSensor, String>() {
            @Override
            public String map(WaterSensor value) throws Exception {
                return value.id;
            }
        }).print("匿名内部类");

        //自定义实现列实现类
        waterSensorDataStreamSource.map(new MyMapFunction()).print("实现类").setParallelism(1);
        waterSensorDataStreamSource.map(data -> (data.id)).print("lamda表达式");
        env.execute();
    }

    public static class MyMapFunction implements MapFunction<WaterSensor, String> {
        @Override
        public String map(WaterSensor value) throws Exception {
            return value.id;
        }
    }
}