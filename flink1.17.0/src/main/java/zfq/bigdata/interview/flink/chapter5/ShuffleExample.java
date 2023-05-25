package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName ShuffleExample
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 16:48
 * @Version 1.0
 */
public class ShuffleExample {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<String> stre = env.socketTextStream("hadoop31", 7777);
        env.setParallelism(2);

        stre.shuffle().print();

        env.execute();
    }
}