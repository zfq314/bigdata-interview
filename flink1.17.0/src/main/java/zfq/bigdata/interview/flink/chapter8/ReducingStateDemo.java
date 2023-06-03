package zfq.bigdata.interview.flink.chapter8;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.state.ReducingState;
import org.apache.flink.api.common.state.ReducingStateDescriptor;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.KeyedProcessFunction;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;

/**
 * @ClassName ReducingStateDemo
 * @Description TODO 案例：计算每种传感器的水位和
 * @Author ZFQ
 * @Date 2023/6/3 14:42
 * @Version 1.0
 */
public class ReducingStateDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        env.setParallelism(1);

        SingleOutputStreamOperator<WaterSensor> stream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(WatermarkStrategy.<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                        .withTimestampAssigner((data, ts) -> data.getTs() * 1000L)

                );
        stream.keyBy(data -> data.getId())
                .process(
                        new KeyedProcessFunction<String, WaterSensor, String>() {
                            //记录状态
                            private ReducingState<Integer> sumVcState;

                            @Override
                            public void open(Configuration parameters) throws Exception {
                                sumVcState = this
                                        .getRuntimeContext()
                                        .getReducingState(new ReducingStateDescriptor<Integer>("sumVcState", Integer::sum, Integer.class));
                            }

                            @Override
                            public void processElement(WaterSensor value, Context ctx, Collector<String> out) throws Exception {
                                sumVcState.add(value.getVc());
                                out.collect(String.valueOf(sumVcState.get()));
                            }
                        }
                ).print();


        env.execute();
    }
}