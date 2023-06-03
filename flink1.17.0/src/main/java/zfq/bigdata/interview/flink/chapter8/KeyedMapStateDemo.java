package zfq.bigdata.interview.flink.chapter8;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.state.MapState;
import org.apache.flink.api.common.state.MapStateDescriptor;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.KeyedProcessFunction;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;
import java.util.Map;

/**
 * @ClassName KeyedMapStateDemo
 * @Description TODO 统计每种传感器每种水位值出现的次数。
 * @Author ZFQ
 * @Date 2023/6/3 14:11
 * @Version 1.0
 */
public class KeyedMapStateDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        env.setParallelism(1);

        SingleOutputStreamOperator<WaterSensor> stream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(WatermarkStrategy
                        .<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                        .withTimestampAssigner((data, ts) -> data.getTs() * 1000L)
                );
        stream.keyBy(data -> data.getId())
                .process(
                        new KeyedProcessFunction<String, WaterSensor, String>() {
                            //定义状态
                            MapState<Integer, Integer> mapState;

                            @Override
                            public void open(Configuration parameters) throws Exception {
                                super.open(parameters);
                                mapState = getRuntimeContext().getMapState(new MapStateDescriptor<Integer, Integer>("mapState", Types.INT, Types.INT));
                            }

                            @Override
                            public void processElement(WaterSensor value, Context ctx, Collector<String> out) throws Exception {
                                //1 判断是否存在vc对应的key
                                Integer vc = value.getVc();
                                if (mapState.contains(vc)) {
                                    //如果存在这个值的话 value直接加1
                                    Integer count = mapState.get(vc);
                                    mapState.put(vc, ++count);
                                } else {
                                    //如果不存在这个key  需要初始化put进去
                                    mapState.put(vc, 1);
                                }
                                //遍历map状态，输出每个k-v的值
                                StringBuilder outStr = new StringBuilder();
                                outStr.append("======================================\n");
                                outStr.append("传感器id为" + value.getId() + "\n");
                                for (Map.Entry<Integer, Integer> vcCount : mapState.entries()) {
                                    outStr.append(vcCount.toString() + "\n");
                                }
                                outStr.append("======================================\n");

                                out.collect(outStr.toString());
                            }
                        }
                ).print();
        //  vcCountMapState.get();          // 对本组的Map状态，根据key，获取value
        //  vcCountMapState.contains();     // 对本组的Map状态，判断key是否存在
        //  vcCountMapState.put(, );        // 对本组的Map状态，添加一个 键值对
        //  vcCountMapState.putAll();  // 对本组的Map状态，添加多个 键值对
        //  vcCountMapState.entries();      // 对本组的Map状态，获取所有键值对
        //  vcCountMapState.keys();         // 对本组的Map状态，获取所有键
        //  vcCountMapState.values();       // 对本组的Map状态，获取所有值
        //  vcCountMapState.remove();   // 对本组的Map状态，根据指定key，移除键值对
        //  vcCountMapState.isEmpty();      // 对本组的Map状态，判断是否为空
        //  vcCountMapState.iterator();     // 对本组的Map状态，获取迭代器
        //  vcCountMapState.clear();        // 对本组的Map状态，清空
        env.execute();
    }
}