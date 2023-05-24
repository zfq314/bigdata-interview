package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.connector.kafka.source.KafkaSource;
import org.apache.flink.connector.kafka.source.enumerator.initializer.OffsetsInitializer;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName SourceKafka
 * @Description TODO 从kafka读取数据
 * @Author ZFQ
 * @Date 2023/5/24 18:15
 * @Version 1.0
 */
public class SourceKafka {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        KafkaSource<String> kafkaSource = KafkaSource.<String>builder()
                //设置一些kafka的连接
                .setBootstrapServers("hadoop31:9092")
                .setTopics("clicks")
                .setGroupId("decent")
                .setStartingOffsets(OffsetsInitializer.latest())
                .setValueOnlyDeserializer(new SimpleStringSchema())
                .build();

        DataStreamSource<String> stream = env.fromSource(kafkaSource, WatermarkStrategy.noWatermarks(), "kafka-source");
        stream.print("kafka");
        env.execute("kafka");

        //创建topic
        //kafka-topics.sh --zookeeper hadoop31:2181 --create --topic test --partitions 3 --replication-factor 2

        //查看kafka的topic
        //kafka-topics.sh --zookeeper hadoop31:2181 --list

        //启动生产者
        //kafka-console-producer.sh --broker-list hadoop31:9092 --topic clicks

        //启动消费者
        //kafka-console-consumer.sh --bootstrap-server hadoop31:9092 --topic clicks --from-beginning
    }
}