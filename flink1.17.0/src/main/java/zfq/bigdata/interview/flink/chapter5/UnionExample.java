package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName UnionExample
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 17:20
 * @Version 1.0
 */
public class UnionExample {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);


        DataStreamSource<Integer> ds1 = env.fromElements(1, 2, 3);
        DataStreamSource<Integer> ds2 = env.fromElements(4, 5, 6);
        DataStreamSource<String> ds3 = env.fromElements("7", "8", "9");

        ds1.union(ds2, ds3.map(Integer::valueOf))
                .print();

        env.execute();
    }
}