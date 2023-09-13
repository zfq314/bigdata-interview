package com.decent.flinkcdc;

import com.ververica.cdc.connectors.mysql.MySqlSource;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.source.SourceFunction;

import java.util.Properties;

/**
 * @ClassName Flink2kafka
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/9/12 11:17
 * @Version 1.0
 */
public class Flink2kafka {
    public static void main(String[] args) throws Exception {
        SourceFunction<String> sourceFunction = MySqlSource.<String>builder()
                .hostname("10.10.80.140")
                .port(3306)
                .databaseList("decent_cloud")
                .tableList("decent_cloud.t_sale_from")
                .username("dba")
                .password("Decent@2023dba")
                //.deserializer(new StringDebeziumDeserializationSchema())
                .serverTimeZone("Asia/Shanghai")
                .debeziumProperties(getDebeziumProperties())
                .deserializer(new JsonDebeziumDeserializationSchema())
                .build();
        StreamExecutionEnvironment executionEnvironment = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<String> stringDataStreamSource = executionEnvironment.addSource(sourceFunction);

        String topic = "t_sale_from";
        stringDataStreamSource.addSink(MyKafkaUtil.getKafkaProducer(topic));

        executionEnvironment.execute("MySqlBinlogSourceExample");
    }

    //时间戳转化
    private static Properties getDebeziumProperties() {
        Properties properties = new Properties();
        properties.setProperty("converters", "dateConverters");
        //根据类在那个包下面修改
        properties.setProperty("dateConverters.type", "com.decent.flinkcdc.MySqlDateTimeConverter");
        properties.setProperty("dateConverters.format.date", "yyyy-MM-dd");
        properties.setProperty("dateConverters.format.time", "HH:mm:ss");
        properties.setProperty("dateConverters.format.datetime", "yyyy-MM-dd HH:mm:ss");
        properties.setProperty("dateConverters.format.timestamp", "yyyy-MM-dd HH:mm:ss");
        properties.setProperty("dateConverters.format.timestamp.zone", "UTC+8");
        properties.setProperty("debezium.snapshot.locking.mode", "none"); //全局读写锁，可能会影响在线业务，跳过锁设置
        properties.setProperty("include.schema.changes", "true");
        properties.setProperty("bigint.unsigned.handling.mode", "long");
        properties.setProperty("decimal.handling.mode", "double");
        return properties;
    }
}