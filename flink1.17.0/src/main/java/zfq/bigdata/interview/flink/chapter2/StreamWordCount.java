package zfq.bigdata.interview.flink.chapter2;

import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.java.tuple.Tuple;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.api.java.utils.ParameterTool;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.KeyedStream;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.Collector;

/**
 * @ClassName StreamWordCount
 * @Description TODO 流处理
 * @Author ZFQ
 * @Date 2023/5/23 18:17
 * @Version 1.0
 */
public class StreamWordCount {
    public static void main(String[] args) throws Exception {
        //本地配置
        Configuration configuration = new Configuration();
        configuration.setInteger("rest.port", 8888);
        // 报下面的这这个错误， 获取环境的时候不能用new
        // No execution.target specified in your configuration file.
        // 错误写法 new StreamExecutionEnvironment.getExecutionEnvironment(configuration);
        StreamExecutionEnvironment streamEnv = StreamExecutionEnvironment.getExecutionEnvironment(configuration);
        // 获取参数
        // 传参样式 --host hadoop31 --port 7777
        ParameterTool parameterTool = ParameterTool.fromArgs(args);
        int port = parameterTool.getInt("port");
        String host = parameterTool.get("host");
        // 核心逻辑
        DataStreamSource<String> stringDataStreamSource = streamEnv.socketTextStream(host, port);

        SingleOutputStreamOperator<Tuple2<String, Long>> tuple2SingleOutputStreamOperator = stringDataStreamSource.flatMap(new FlatMapFunction<String, Tuple2<String, Long>>() {
            @Override
            public void flatMap(String string, Collector<Tuple2<String, Long>> out) throws Exception {
                String[] words = string.split(" ");
                for (String word : words) {
                    out.collect(Tuple2.of(word, 1L));
                }
            }
        });
        KeyedStream<Tuple2<String, Long>, Tuple> tuple2TupleKeyedStream = tuple2SingleOutputStreamOperator.keyBy(0);

        SingleOutputStreamOperator<Tuple2<String, Long>> sum = tuple2TupleKeyedStream.sum(1);
        sum.print();

        streamEnv.execute();
    }
}