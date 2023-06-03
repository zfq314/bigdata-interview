package zfq.bigdata.interview.flink.chapter8;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.state.ListState;
import org.apache.flink.api.common.state.ListStateDescriptor;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.KeyedProcessFunction;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;
import java.util.ArrayList;

/**
 * @ClassName KeyedListStateDemo
 * @Description TODO 案例:针对每种传感器输出最高的3个水位值
 * @Author ZFQ
 * @Date 2023/6/3 10:57
 * @Version 1.0
 */
public class KeyedListStateDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        SingleOutputStreamOperator<WaterSensor> stream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(
                        WatermarkStrategy
                                .<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                                .withTimestampAssigner((data, ts) -> data.getTs() * 1000L)
                );
        stream.keyBy(data -> data.getId())
                .process(
                        new KeyedProcessFunction<String, WaterSensor, String>() {
                            //定义状态
                            ListState<Integer> vcListState;

                            // TODO 2.在open方法中，初始化状态
                            // 状态描述器两个参数：第一个参数，起个名字，不重复；第二个参数，存储的类型
                            @Override
                            public void open(Configuration parameters) throws Exception {
                                super.open(parameters);
                                  vcListState = getRuntimeContext().getListState(new ListStateDescriptor<Integer>("vcListState", Types.INT));
                            }

                            //元素遍历
                            @Override
                            public void processElement(WaterSensor value, Context ctx, Collector<String> out) throws Exception {
                                //遍历元素
                                //将数据存入到list状态里面
                                vcListState.add(value.getVc());
                                //将list状态拿出来，iterable,拷贝到一个List里面，排序， 只留3个最大的
                                Iterable<Integer> vcListIt = vcListState.get();
                                // 2.1 拷贝到List中
                                ArrayList<Integer> vcList = new ArrayList<>();
                                for (Integer integer : vcListIt) {
                                    vcList.add(integer);
                                }
                                vcList.sort(((o1, o2) -> o2 - o1));
                                // 2.3 只保留最大的3个(list中的个数一定是连续变大，一超过3就立即清理即可)
                                if (vcList.size() > 3) {
                                    //将最后一个元素清除
                                    vcList.remove(3);
                                }
                                out.collect("传感器id为" + value.getId() + ",最大的3个水位值=" + vcList.toString());
                                // 3.更新list状态
                                vcListState.update(vcList);

                                // vcListState.get(); //取出 list状态 本组的数据，是一个Iterable
                                // vcListState.add(); // 向 list状态 本组 添加一个元素
                                // vcListState.addAll();// 向 list状态 本组 添加多个元素
                                // vcListState.update();// 更新 list状态 本组数据（覆盖）
                                // vcListState.clear(); // 清空List状态 本组数据

                            }

                        }
                ).print();


        env.execute();
    }
}