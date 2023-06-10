package zfq.bigdata.interview.flink.chapter8;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.state.StateTtlConfig;
import org.apache.flink.api.common.state.ValueState;
import org.apache.flink.api.common.state.ValueStateDescriptor;
import org.apache.flink.api.common.time.Time;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.KeyedProcessFunction;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;

/**
 * @ClassName StateTTLDemo
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/6/10 11:01
 * @Version 1.0
 */
public class StateTTLDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);
        SingleOutputStreamOperator<WaterSensor> stream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(
                        WatermarkStrategy.<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                                .withTimestampAssigner((data, ts) -> data.getTs() * 1000L)
                );
        stream.keyBy(data -> data.getId())
                .process(
                        new KeyedProcessFunction<String, WaterSensor, String>() {
                            ValueState<Integer> lastVcState;

                            @Override
                            public void open(Configuration parameters) throws Exception {
                                super.open(parameters);
                                // TODO 1.创建 StateTtlConfig
                                StateTtlConfig stateTtlConfig = StateTtlConfig.newBuilder(
                                        Time.seconds(5) //过期时间5s

                                )      //.setUpdateType(StateTtlConfig.UpdateType.OnCreateAndWrite) // 状态 创建和写入（更新） 更新 过期时间
                                        .setUpdateType(StateTtlConfig.UpdateType.OnReadAndWrite) // 状态 读取、创建和写入（更新） 更新 过期时间
                                        .setStateVisibility(StateTtlConfig.StateVisibility.NeverReturnExpired) // 不返回过期的状态值
                                        .build();
                                // TODO 2.状态描述器 启用 TTL
                                ValueStateDescriptor<Integer> stateDescriptor = new ValueStateDescriptor<>("lastVcState", Types.INT);
                                stateDescriptor.enableTimeToLive(stateTtlConfig);


                                this.lastVcState = getRuntimeContext().getState(stateDescriptor);
                            }

                            @Override
                            public void processElement(WaterSensor value, Context ctx, Collector<String> out) throws Exception {
                                // 先获取状态值，打印 ==》 读取状态
                                Integer lastVc = lastVcState.value();
                                out.collect("key=" + value.getId() + ",状态值=" + lastVc);
                                // 如果水位大于10，更新状态值 ===》 写入状态
                                if (value.getVc() > 10) {
                                    lastVcState.update(value.getVc());
                                }
                            }
                        }
                ).print();

        env.execute();
    }
}