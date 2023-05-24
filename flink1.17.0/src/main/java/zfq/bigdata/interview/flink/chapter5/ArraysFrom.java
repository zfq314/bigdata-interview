package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

import java.util.Arrays;
import java.util.List;

/**
 * @ClassName ArraysFrom
 * @Description TODO 从集合中读取数据
 * @Author ZFQ
 * @Date 2023/5/24 17:57
 * @Version 1.0
 */
public class ArraysFrom {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment executionEnvironment = StreamExecutionEnvironment.getExecutionEnvironment();

        List<Integer> integers = Arrays.asList(1, 3, 5, 6);

        DataStreamSource<List<Integer>> streamSource = executionEnvironment.fromElements(integers);

        streamSource.print();

        executionEnvironment.execute();


    }
}