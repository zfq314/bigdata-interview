package zfq.bigdata.flink.api;

import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.KeyedStream;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.Collector;

/**
 * @ClassName StreamWrodCount
 * @Description TODO 流处理WordCount
 * @Author ZFQ
 * @Date 2023/11/2 13:44
 * @Version 1.0
 */
public class StreamWrodCount {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment executionEnvironment = StreamExecutionEnvironment.getExecutionEnvironment();

        executionEnvironment.setParallelism(1);
        //读取hdfs上的文件
        DataStreamSource<String> stringDataStreamSource = executionEnvironment.readTextFile("hdfs://mycluster/flink-dist/plugins/README.txt");

        SingleOutputStreamOperator<Tuple2<String, Long>> tuple2SingleOutputStreamOperator =
                stringDataStreamSource.flatMap(new FlatMapFunction<String, Tuple2<String, Long>>() {
                                                   @Override
                                                   public void flatMap(String value, Collector<Tuple2<String, Long>> out) throws Exception {
                                                       String[] words = value.split(" ");
                                                       for (String word : words) {
                                                           out.collect(Tuple2.of(word, 1L));
                                                       }
                                                   }
                                               }
                );

        KeyedStream<Tuple2<String, Long>, String> keyedStream = tuple2SingleOutputStreamOperator.keyBy(data -> data.f0);

        SingleOutputStreamOperator<Tuple2<String, Long>> sum = keyedStream.sum(1);

        sum.print();
        executionEnvironment.execute();

    }
}