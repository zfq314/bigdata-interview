package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.functions.FilterFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName TransFunctionUDF
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 15:51
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
        //方式一 实现FilterFunction接口
        waterSensorDataStreamSource.filter(new UserFilter()).print();

        // 方式二 通过匿名类来实现FilterFunction接口：
        waterSensorDataStreamSource.filter(new FilterFunction<WaterSensor>() {
            @Override
            public boolean filter(WaterSensor value) throws Exception {
                return value.id.equals("sensor_1");
            }
        }).print("匿名类");

        //方式二的优化：为了类可以更加通用，我们还可以将用于过滤的关键字"home"抽象出来作为类的属性，调用构造方法时传进去。
        waterSensorDataStreamSource.filter(new FilterFunctionImpl("sensor_1")).print("属性");

        //方式三：采用匿名函数（Lambda）
        waterSensorDataStreamSource.filter(sensor -> "sensor_1".equals(sensor.id)).print("匿名函数");
        env.execute();
    }

    public static class UserFilter implements FilterFunction<WaterSensor> {
        @Override
        public boolean filter(WaterSensor value) throws Exception {
            return value.id.equals("sensor_1");
        }
    }

    public static class FilterFunctionImpl implements FilterFunction<WaterSensor> {
        private String id;

        FilterFunctionImpl(String id) {
            this.id = id;
        }

        @Override
        public boolean filter(WaterSensor value) throws Exception {
            return this.id.equals(value.id);
        }
    }
}