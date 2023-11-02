package zfq.bigdata.flink.api;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.connector.kafka.source.KafkaSource;
import org.apache.flink.connector.kafka.source.enumerator.initializer.OffsetsInitializer;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import zfq.bigdata.flink.utils.ConfUtils;

/**
 * @ClassName DataFromKafka
 * @Description TODO 从kafka中读取数据
 * @Author ZFQ
 * @Date 2023/11/2 14:11
 * @Version 1.0
 */
public class DataFromKafka {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment executionEnvironment = StreamExecutionEnvironment.getExecutionEnvironment();
        //获取Kafka的配置
        String brokeList = ConfUtils.getProperties("brokerList");
        String topic = ConfUtils.getProperties("topic");
        //从kafka读取数据，需要kafka的连接器，kafka作为source
        KafkaSource<String> kafkaSource = KafkaSource.<String>builder()
                .setBootstrapServers(brokeList)//server
                .setTopics(topic)//topic
                .setGroupId("decent")//customer_group
                .setStartingOffsets(OffsetsInitializer.latest())//offset
                .setValueOnlyDeserializer(new SimpleStringSchema())// schema
                .build();

        DataStreamSource<String> stringDataStreamSource = executionEnvironment.fromSource(kafkaSource, WatermarkStrategy.noWatermarks(), "kafka-topic");
        stringDataStreamSource.print();

        executionEnvironment.execute();
    }
}