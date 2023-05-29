package zfq.bigdata.interview.flink.chapter6;

import org.apache.flink.api.common.functions.AggregateFunction;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.windowing.assigners.TumblingProcessingTimeWindows;
import org.apache.flink.streaming.api.windowing.time.Time;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

/**
 * @ClassName WindowAggregateDemo
 * @Description TODO 聚合函数
 * @Author ZFQ
 * @Date 2023/5/29 18:05
 * @Version 1.0
 */
public class WindowAggregateDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        SingleOutputStreamOperator<WaterSensor> sensorDs = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction());

        sensorDs.keyBy(data -> data.id)
                //窗口分配器
                .window(TumblingProcessingTimeWindows.of(Time.seconds(10)))
                .aggregate(new AggregateFunction<WaterSensor, Integer, String>() {
                    @Override
                    //创建累加器
                    public Integer createAccumulator() {
                        return 0;
                    }

                    @Override
                    public Integer add(WaterSensor value, Integer accumulator) {

                        System.out.println("调用add方法,value=" + value);
                        return accumulator + value.getVc();
                    }

                    @Override
                    public String getResult(Integer accumulator) {
                        System.out.println("调用getResult方法");
                        return accumulator.toString();
                    }

                    @Override
                    public Integer merge(Integer a, Integer b) {
                        System.out.println("调用merge方法");
                        return null;
                    }
                }).print();

        env.execute();
    }
}