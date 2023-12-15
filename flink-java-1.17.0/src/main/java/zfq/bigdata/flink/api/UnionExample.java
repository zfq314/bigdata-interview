package zfq.bigdata.flink.api;

import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName UnionExample
 * @Description TODO 多条流union,只能是union 同数据类型的流
 * @Author ZFQ
 * @Date 2023/12/15 15:36
 * @Version 1.0
 */
public class UnionExample {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        DataStreamSource<Integer> ds1 = env.fromElements(1, 2, 3);
        DataStreamSource<Integer> ds2 = env.fromElements(2, 2, 3);
        DataStreamSource<String> ds3 = env.fromElements("2", "2", "3");

        ds1.union(ds2, ds3.map(Integer::valueOf))
                .print();


        env.execute();

    }
}