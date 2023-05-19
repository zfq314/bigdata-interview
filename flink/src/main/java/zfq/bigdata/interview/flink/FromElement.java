package zfq.bigdata.interview.flink;

import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName FromElement
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/19 10:04
 * @Version 1.0
 */
public class FromElement {
    public static void main(String[] args) throws Exception {
        Configuration configuration = new Configuration();
        configuration.setInteger("rest.port",8081);
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment(configuration);

        DataStreamSource<String> stringDataStreamSource = env.fromElements("hive", "flink", "spark");
        stringDataStreamSource.print();
        env.execute("FromElement Job");
    }
}