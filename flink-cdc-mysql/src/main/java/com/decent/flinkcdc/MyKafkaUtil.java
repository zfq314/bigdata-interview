package com.decent.flinkcdc;

import org.apache.flink.api.common.serialization.SimpleStringSchema;
import org.apache.flink.streaming.connectors.kafka.FlinkKafkaProducer;


/**
 * @ClassName MyKafkaUtil
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/9/12 11:13
 * @Version 1.0
 */
public class MyKafkaUtil {
    public static FlinkKafkaProducer<String> getKafkaProducer(String topic){
        String brokerList = ConfigurationUtils.getProperties("brokerList");
        return new FlinkKafkaProducer<String>(brokerList, topic, new SimpleStringSchema());
    }
}