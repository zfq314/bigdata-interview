package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.api.connector.source.util.ratelimit.RateLimiterStrategy;
import org.apache.flink.connector.datagen.source.DataGeneratorSource;
import org.apache.flink.connector.datagen.source.GeneratorFunction;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;


/**
 * @ClassName DataGeneratorSource
 * @Description TODO 从数据生成器读取数据
 * @Author ZFQ
 * @Date 2023/5/25 10:23
 * @Version 1.0
 */
public class DataGeneratorSources {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        DataGeneratorSource<String> dataGeneratorSource = new DataGeneratorSource<>(
                new GeneratorFunction<Long, String>() {
                    @Override
                    public String map(Long value) throws Exception {
                        return "Number:" + value;
                    }
                },
                Long.MAX_VALUE, //  263-1.
                RateLimiterStrategy.perSecond(10),
                Types.STRING
        );
        env.fromSource(dataGeneratorSource, WatermarkStrategy.noWatermarks(), "dataGeneratorSource")
                .print();
        env.execute();
    }
}