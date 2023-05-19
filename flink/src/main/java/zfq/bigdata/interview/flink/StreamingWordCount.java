package zfq.bigdata.interview.flink;

import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.Collector;


/**
 * @ClassName StreamingWordCount
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/18 17:49
 * @Version 1.0
 */
public class StreamingWordCount {

    public static void main(String[] args) throws Exception {
        //创建流式计算的ExecutionEnvironment
        Configuration configuration = new Configuration();
        configuration.setInteger("rest.port",8081);
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment(configuration);
        //调用Source，指定Socket地址和端口
        DataStream<String> lines = env.socketTextStream("hadoop31", 7777);
        //切分压平并将单词和一放入元组中
        DataStream<Tuple2<String, Integer>> words = lines.
                flatMap(new FlatMapFunction<String, Tuple2<String, Integer>>() {
                    @Override
                    public void flatMap(String line, Collector<Tuple2<String, Integer>> collector)
                            throws Exception {
                        String[] words = line.split("\\s");
                        for (String word : words) {
                            collector.collect(Tuple2.of(word, 1));
                        }
                    }
                });
        //按照key分组并聚合
        DataStream<Tuple2<String, Integer>> result = words.keyBy(0).sum(1);
        //将结果打印到控制台
        result.print();
        //执行
        env.execute("StreamingWordCount");

        //socketTextStream 非并行的Source
        //KafkaSource 并行的Source

        // window 查看端口占用 netstat -aon|findstr "8081"
        // 杀进程 taskkill -PID 81572 -F
    }
}