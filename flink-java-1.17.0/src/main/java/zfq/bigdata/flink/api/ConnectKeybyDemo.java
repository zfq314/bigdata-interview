package zfq.bigdata.flink.api;

import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.api.java.tuple.Tuple3;
import org.apache.flink.streaming.api.datastream.ConnectedStreams;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.co.CoProcessFunction;
import org.apache.flink.util.Collector;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName ConnectKeybyDemo
 * @Description TODO 连接两条流，输出能根据id匹配上的数据（类似inner join效果）
 * @Author ZFQ
 * @Date 2023/12/15 15:59
 * @Version 1.0
 */
public class ConnectKeybyDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(2);

        DataStreamSource<Tuple2<Integer, String>> tuple2DataStreamSource = env.fromElements(
                Tuple2.of(1, "a1"),
                Tuple2.of(1, "a2"),
                Tuple2.of(2, "b"),
                Tuple2.of(3, "c")
        );
        DataStreamSource<Tuple3<Integer, String, Integer>> tuple3DataStreamSource = env.fromElements(
                Tuple3.of(1, "aa1", 1),
                Tuple3.of(1, "aa2", 2),
                Tuple3.of(2, "bb", 1),
                Tuple3.of(3, "cc", 1)
        );
        ConnectedStreams<Tuple2<Integer, String>, Tuple3<Integer, String, Integer>> connectedStreams = tuple2DataStreamSource.connect(tuple3DataStreamSource);
        // 多并行度下，需要根据 关联条件 进行keyby，才能保证key相同的数据到一起去，才能匹配上
        ConnectedStreams<Tuple2<Integer, String>, Tuple3<Integer, String, Integer>> tuple2Tuple3ConnectedStreams = connectedStreams.keyBy(s1 -> s1.f0, s2 -> s2.f0);
        SingleOutputStreamOperator<String> result = tuple2Tuple3ConnectedStreams.process(
                new CoProcessFunction<Tuple2<Integer, String>, Tuple3<Integer, String, Integer>, String>() {
                    //定义HashMap缓存来过的数据key=id,value=list<数据>
                    Map<Integer, List<Tuple2<Integer, String>>> s1Cache = new HashMap<>();

                    Map<Integer, List<Tuple3<Integer, String, Integer>>> s2Cache = new HashMap<>();

                    @Override
                    public void processElement1(Tuple2<Integer, String> value, Context ctx, Collector<String> out) throws Exception {
                        //来过s1的数据都存起来
                        Integer id = value.f0;
                        if (!s1Cache.containsKey(id)) {
                            //第一条数据 初始化value的list放入hashmap
                            List<Tuple2<Integer, String>> s1Value = new ArrayList<>();
                            s1Value.add(value);
                            s1Cache.put(id, s1Value);
                        } else {
                            // 不是第一条，直接添加到 list中
                            s1Cache.get(id).add(value);
                        }
                        //根据id，查找s2的数据，只输出 匹配上 的数据
                        if (s2Cache.containsKey(id)) {
                            for (Tuple3<Integer, String, Integer> s2Element : s2Cache.get(id)) {
                                out.collect("s1:" + value + "<--------->s2:" + s2Element);
                            }
                        }
                    }

                    @Override
                    public void processElement2(Tuple3<Integer, String, Integer> value, Context ctx, Collector<String> out) throws Exception {
                        Integer id = value.f0;
                        //来过s2的数据都存起来
                        if (!s2Cache.containsKey(id)) {
                            //第一条数据 初始化value的list放入hashmap
                            List<Tuple3<Integer, String, Integer>> s2Values = new ArrayList<>();
                            s2Values.add(value);
                            s2Cache.put(id, s2Values);
                        } else {
                            // 1.2 不是第一条，直接添加到 list中
                            s2Cache.get(id).add(value);
                        }
                        //根据id，查找s1的数据，只输出 匹配上 的数据
                        if (s1Cache.containsKey(id)) {
                            for (Tuple2<Integer, String> s1Element : s1Cache.get(id)) {
                                out.collect("s1:" + s1Element + "<--------->s2:" + value);
                            }
                        }
                    }
                }
        );
        result.print();


        env.execute();
    }
}