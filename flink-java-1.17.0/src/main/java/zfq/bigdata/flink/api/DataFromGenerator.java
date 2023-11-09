package zfq.bigdata.flink.api;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.api.connector.source.util.ratelimit.RateLimiterStrategy;
import org.apache.flink.connector.datagen.source.DataGeneratorSource;
import org.apache.flink.connector.datagen.source.GeneratorFunction;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName DataFromGenerator
 * @Description TODO 从数据生成器读取数据
 * @Author ZFQ
 * @Date 2023/11/9 11:21
 * @Version 1.0
 */
public class DataFromGenerator {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        //定义source
        DataGeneratorSource<String> dataGeneratorSource = new DataGeneratorSource<>(new GeneratorFunction<Long, String>() {
            @Override
            public String map(Long value) throws Exception {
                return "Number:" + value;
            }
        },
                Long.MAX_VALUE,
                RateLimiterStrategy.perSecond(10),
                Types.STRING

        );
        env.fromSource(dataGeneratorSource, WatermarkStrategy.noWatermarks(), "datagenerator").print();
        env.execute();
    }
}