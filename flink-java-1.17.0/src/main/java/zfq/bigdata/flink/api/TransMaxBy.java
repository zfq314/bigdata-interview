package zfq.bigdata.flink.api;

import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.common.functions.ReduceFunction;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import zfq.bigdata.flink.bean.WaterSensor;


/**
 * @ClassName TransMaxBy
 * @Description TODO 实现max/maxby的功能
 * @Author ZFQ
 * @Date 2023/11/15 17:31
 * @Version 1.0
 */
public class TransMaxBy {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment executionEnvironment = StreamExecutionEnvironment.getExecutionEnvironment();
        executionEnvironment.fromElements(
                new WaterSensor("sensor_1", 1L, 1),
                new WaterSensor("sensor_1", 2L, 2),
                new WaterSensor("sensor_2", 2L, 2),
                new WaterSensor("sensor_3", 3L, 3)
        ).map(new WaterSensorMapFunction())
                .keyBy(WaterSensor::getId)
                .reduce(new ReduceFunction<WaterSensor>() {
                    @Override
                    public WaterSensor reduce(WaterSensor value1, WaterSensor value2) throws Exception {
                        System.out.println("Demo7_Reduce.reduce");

                        int maxVc = Math.max(value1.getVc(), value2.getVc());
                        //实现max(vc)的效果  取最大值，其他字段以当前组的第一个为主
                        //value1.setVc(maxVc);
                        //实现maxBy(vc)的效果  取当前最大值的所有字段
                        if (value1.getVc() > value2.getVc()) {
                            value1.setVc(maxVc);
                            return value1;
                        } else {
                            value2.setVc(maxVc);
                            return value2;
                        }
                    }
                })
                .print();
        executionEnvironment.execute();
    }

    private static class WaterSensorMapFunction implements MapFunction<WaterSensor,WaterSensor> {
        @Override
        public WaterSensor map(WaterSensor value) throws Exception {
            return value;
        }
    }
}