package zfq.bigdata.flink.api;

import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

import java.util.Arrays;

/**
 * @ClassName DataFromCollection
 * @Description TODO 从集合中读取数据
 * @Author ZFQ
 * @Date 2023/11/7 17:27
 * @Version 1.0
 */
public class DataFromCollection {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<Integer> integerDataStreamSource = env.fromCollection(Arrays.asList(1, 22, 3));
        integerDataStreamSource.print();

        env.execute();
    }
}