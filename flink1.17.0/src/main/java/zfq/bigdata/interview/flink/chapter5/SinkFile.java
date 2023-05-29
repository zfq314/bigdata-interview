package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.serialization.SimpleStringEncoder;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.api.connector.source.util.ratelimit.RateLimiterStrategy;
import org.apache.flink.configuration.MemorySize;
import org.apache.flink.connector.datagen.source.DataGeneratorSource;
import org.apache.flink.connector.datagen.source.GeneratorFunction;
import org.apache.flink.connector.file.sink.FileSink;
import org.apache.flink.core.fs.Path;
import org.apache.flink.streaming.api.CheckpointingMode;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.sink.filesystem.OutputFileConfig;
import org.apache.flink.streaming.api.functions.sink.filesystem.bucketassigners.DateTimeBucketAssigner;
import org.apache.flink.streaming.api.functions.sink.filesystem.rollingpolicies.DefaultRollingPolicy;

import java.time.Duration;
import java.time.ZoneId;


/**
 * @ClassName SinkFile
 * @Description TODO 输出到文件
 * @Author ZFQ
 * @Date 2023/5/29 10:44
 * @Version 1.0
 */
public class SinkFile {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        // 每个目录中，都有 并行度个数的 文件在写入
        //env.setParallelism(2);
        // 必须开启checkpoint，否则一直都是 .inprogress
        env.enableCheckpointing(2000, CheckpointingMode.EXACTLY_ONCE);

        //数据生成器生成数据
        DataGeneratorSource<String> sourceData = new DataGeneratorSource<>(new GeneratorFunction<Long, String>() {
            @Override
            public String map(Long aLong) throws Exception {
                return "Number:" + aLong;
            }
        },
                Long.MAX_VALUE,
                RateLimiterStrategy.perSecond(1000),
                Types.STRING
        );
        DataStreamSource<String> stringDataStreamSource = env.fromSource(sourceData, WatermarkStrategy.noWatermarks(), "data-generator");
        //输出到文件系统
        FileSink<String> fieSink = FileSink.<String>forRowFormat(
                new Path("f:/tmp"),
                new SimpleStringEncoder<>("UTF-8")
        )
                //输出文件的一些配置，文件的前缀，文件的后缀
                .withOutputFileConfig(
                        OutputFileConfig.builder()
                                .withPartPrefix("decent")
                                .withPartSuffix(".log")
                                .build()
                )// 按照目录分桶,每分钟一个目录
                .withBucketAssigner(
                        new DateTimeBucketAssigner<>("yyyy-MM-dd HH", ZoneId.systemDefault()))
                //文件滚动策略,1分钟或者1m
                .withRollingPolicy(
                        DefaultRollingPolicy.builder()
                                .withRolloverInterval(Duration.ofMillis(1))
                                .withMaxPartSize(new MemorySize(1024 * 1024))
                                .build()
                )
                .build();
        stringDataStreamSource.sinkTo(fieSink);
        env.execute();
    }
}