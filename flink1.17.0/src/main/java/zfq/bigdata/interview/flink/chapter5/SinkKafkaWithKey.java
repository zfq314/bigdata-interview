package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.connector.base.DeliveryGuarantee;
import org.apache.flink.connector.kafka.sink.KafkaRecordSerializationSchema;
import org.apache.flink.connector.kafka.sink.KafkaSink;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.kafka.clients.producer.ProducerConfig;
import org.apache.kafka.clients.producer.ProducerRecord;

import javax.annotation.Nullable;
import java.nio.charset.StandardCharsets;

/**
 * @ClassName SinkKafkaWithKey
 * @Description TODO 自定义序列化器，实现带key的record:
 * @Author ZFQ
 * @Date 2023/5/29 14:47
 * @Version 1.0
 */
public class SinkKafkaWithKey {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        DataStreamSource<String> inputStream = env.socketTextStream("hadoop31", 7777);


        KafkaSink<String> kafkaSink = KafkaSink //kafka的配置信息
                //输入的泛型
                .<String>builder()
                .setBootstrapServers("hadoop31:9092,hadoop32:9092,hadoop33:9092")

                .setRecordSerializer(new KafkaRecordSerializationSchema<String>() {
                    /**
                     * 如果要指定写入kafka的key，可以自定义序列化器：
                     * 1、实现 一个接口，重写 序列化 方法
                     * 2、指定key，转成 字节数组
                     * 3、指定value，转成 字节数组
                     * 4、返回一个 ProducerRecord对象，把key、value放进去
                     */
                    @Nullable
                    @Override
                    public ProducerRecord<byte[], byte[]> serialize(String element, KafkaSinkContext kafkaSinkContext, Long timestamp) {
                        String[] splitData = element.split(",");
                        byte[] key = splitData[0].getBytes(StandardCharsets.UTF_8);
                        byte[] value = element.getBytes(StandardCharsets.UTF_8);
                        return new ProducerRecord<>("ws", key, value);
                    }
                })
                .setDeliveryGuarantee(DeliveryGuarantee.EXACTLY_ONCE)
                .setTransactionalIdPrefix("decent-")
                .setProperty(ProducerConfig.TRANSACTION_TIMEOUT_CONFIG, 10 * 60 * 1000 + "")
                .build();
          inputStream.sinkTo(kafkaSink);

        env.execute();
    }
}