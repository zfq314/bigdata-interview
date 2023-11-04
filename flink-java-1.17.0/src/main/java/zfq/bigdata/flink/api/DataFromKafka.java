package zfq.bigdata.flink.api;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.connector.kafka.source.KafkaSource;
import org.apache.flink.connector.kafka.source.enumerator.initializer.OffsetsInitializer;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.KeyedStream;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.Collector;
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
        SingleOutputStreamOperator<Tuple2<String, Long>> tuple2SingleOutputStreamOperator = stringDataStreamSource.flatMap(new FlatMapFunction<String, Tuple2<String, Long>>() {
            @Override
            public void flatMap(String value, Collector<Tuple2<String, Long>> out) throws Exception {
                String[] split = value.split(":");
                for (String s : split) {
                    out.collect(Tuple2.of(s, 1L));
                }
            }
        });
        tuple2SingleOutputStreamOperator.print();
        KeyedStream<Tuple2<String, Long>, String> tuple2StringKeyedStream = tuple2SingleOutputStreamOperator.keyBy(data -> data.f0);
        tuple2StringKeyedStream.sum(1).print();


        executionEnvironment.execute();
    }
}