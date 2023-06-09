package zfq.bigdata.interview.flink.chapter8;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.functions.AggregateFunction;
import org.apache.flink.api.common.state.AggregatingState;
import org.apache.flink.api.common.state.AggregatingStateDescriptor;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.KeyedProcessFunction;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;
//git config --global https.proxy 终端设置代理
//git config --global --unset https.proxy 终端取消代理
/**
 * @ClassName KeyedAggregatingStateDemo
 * @Description TODO 计算每种传感器的平均水位.
 * @Author ZFQ
 * @Date 2023/6/3 14:57
 * @Version 1.0
 */
public class KeyedAggregatingStateDemo {
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

                            AggregatingState<Integer, Double> aggregatingState;

                            @Override
                            public void open(Configuration parameters) throws Exception {
                                super.open(parameters);
                                aggregatingState=getRuntimeContext().getAggregatingState(new AggregatingStateDescriptor<Integer, Tuple2<Integer, Integer>, Double>("vcAvgAggregatingState",
                                        new AggregateFunction<Integer, Tuple2<Integer, Integer>, Double>() {
                                            @Override
                                            public Tuple2<Integer, Integer> createAccumulator() {
                                                return Tuple2.of(0, 0);
                                            }

                                            @Override
                                            public Tuple2<Integer, Integer> add(Integer value, Tuple2<Integer, Integer> accumulator) {
                                                return Tuple2.of(accumulator.f0 + value, accumulator.f1 + 1);
                                            }

                                            @Override
                                            public Double getResult(Tuple2<Integer, Integer> accumulator) {
                                                return accumulator.f0 * 1D / accumulator.f1;
                                            }

                                            @Override
                                            public Tuple2<Integer, Integer> merge(Tuple2<Integer, Integer> a, Tuple2<Integer, Integer> b) {
                                                //return Tuple2.of(a.f0+b.f0,a.f1+b.f1);
                                                return null;
                                            }
                                        }
                                        , Types.TUPLE(Types.INT, Types.INT)
                                ));
                            }

                            @Override
                            public void processElement(WaterSensor value, Context ctx, Collector<String> out) throws Exception {
                                // 将 水位值 添加到  聚合状态中
                                aggregatingState.add(value.getVc());
                                // 从 聚合状态中 获取结果
                                Double vcAvg = aggregatingState.get();
                                out.collect("传感器id为" + value.getId() + ",平均水位值=" + vcAvg);

                                //    vcAvgAggregatingState.get();    // 对 本组的聚合状态 获取结果
                                //    vcAvgAggregatingState.add();    // 对 本组的聚合状态 添加数据，会自动进行聚合
                                //    vcAvgAggregatingState.clear();  // 对 本组的聚合状态 清空数据
                            }
                        }
                ).print();

        env.execute();
    }
}