package com.decent.flinkcdc;

import com.ververica.cdc.connectors.mysql.MySqlSource;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.source.SourceFunction;

/**
 * @ClassName MySqlBinlogSource
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/9/8 17:40
 * @Version 1.0
 */
public class MySqlBinlogSource {
    public static void main(String[] args) throws Exception {
        SourceFunction<String> sourceFunction = MySqlSource.<String>builder()
                .hostname("10.10.80.140")
                .port(3306)
                .databaseList("decent_cloud")
                .tableList("decent_cloud.t_sale_from")
                .username("dba")
                .password("Decent@2023dba")
                //.deserializer(new StringDebeziumDeserializationSchema())
                .deserializer(new JsonDebeziumDeserializationSchema())
                .build();
        StreamExecutionEnvironment executionEnvironment = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<String> stringDataStreamSource = executionEnvironment.addSource(sourceFunction);
        stringDataStreamSource.print();
        executionEnvironment.execute("MySqlBinlogSourceExample");
    }

}