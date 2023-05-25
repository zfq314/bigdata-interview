package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.functions.ReduceFunction;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName Reduce_Max_MaxBy
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 15:33
 * @Version 1.0
 */
public class Reduce_Max_MaxBy {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<String> stream = env.socketTextStream("hadoop31", 7777);

        stream.map(new WaterSensorMapFunction())

                .keyBy(WaterSensor::getId)
                .reduce(new ReduceFunction<WaterSensor>() {
                    @Override
                    public WaterSensor reduce(WaterSensor value1, WaterSensor value2) throws Exception {
                        //实现max(vc)的效果  取最大值，其他字段以当前组的第一个为主
                        //value1.setVc(maxVc);
                        //实现maxBy(vc)的效果  取当前最大值的所有字段
                        int maxVc = Math.max(value1.getVc(), value2.getVc());
                        if (value1.getVc() > value1.getVc()) {
                            value1.setVc(maxVc);
                            return value1;
                        } else {
                            value2.setVc(maxVc);
                            return value2;
                        }
                    }
                }).print();

        env.execute();
    }
}