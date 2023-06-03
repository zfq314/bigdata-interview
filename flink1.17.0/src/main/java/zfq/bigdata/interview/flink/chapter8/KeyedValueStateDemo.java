package zfq.bigdata.interview.flink.chapter8;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.state.ValueState;
import org.apache.flink.api.common.state.ValueStateDescriptor;
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
 * @ClassName KeyedValueStateDemo
 * @Description TODO 案例需求：检测每种传感器的水位值，如果连续的两个水位值超过10，就输出报警
 * @Author ZFQ
 * @Date 2023/6/2 16:12
 * @Version 1.0
 */
public class KeyedValueStateDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        SingleOutputStreamOperator<WaterSensor> stream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(
                        //此处的泛型是为了指定watermark的字段具体采用那个
                        WatermarkStrategy.<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(4))
                                .withTimestampAssigner((data, ts) -> data.getTs() * 1000L)
                );
        stream.keyBy(record -> record.getId())
                .process(
                        new KeyedProcessFunction<String, WaterSensor, String>() {
                            //TODO 1 定义状态
                            ValueState<Integer> valueState;
                            // TODO 2.在open方法中，初始化状态
                            // 状态描述器两个参数：第一个参数，起个名字，不重复；第二个参数，存储的类型


                            @Override
                            public void open(Configuration parameters) throws Exception {
                                super.open(parameters);
                                valueState = getRuntimeContext().getState(new ValueStateDescriptor<Integer>("lastVcState", Types.INT));
                            }

                            @Override
                            public void processElement(WaterSensor value, Context ctx, Collector<String> out) throws Exception {
                                // lastVcState.value();  // 取出 本组 值状态 的数据
                                // lastVcState.update(); // 更新 本组 值状态 的数据
                                // lastVcState.clear();  // 清除 本组 值状态 的数据
                                // 1. 取出上一条数据的水位值(Integer默认值是null，判断)
                                int lastVc = valueState.value() == null ? 0 : valueState.value();
                                // 2. 求差值的绝对值，判断是否超过10
                                Integer vc = value.getVc();
                                if (Math.abs(vc - lastVc) > 10) {
                                    out.collect("传感器=" + value.getId() + "==>当前水位值=" + vc + ",与上一条水位值=" + lastVc + ",相差超过10！！！！");
                                }
                                // 3. 更新状态里的水位值
                                valueState.update(vc);
                            }
                        }
                ).print();


        env.execute();
    }
}