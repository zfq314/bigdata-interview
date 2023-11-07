package zfq.bigdata.flink.api;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.connector.file.src.FileSource;
import org.apache.flink.connector.file.src.reader.TextLineInputFormat;
import org.apache.flink.core.fs.Path;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import sun.misc.Resource;

/**
 * @ClassName DataFromFile
 * @Description TODO 从文件中读取数据
 * @Author ZFQ
 * @Date 2023/11/7 18:24
 * @Version 1.0
 */
public class DataFromFile {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        String path = Resource.class.getResource("/log4j2.xml").getPath();
        FileSource<String> fileSource = FileSource.forRecordStreamFormat(new TextLineInputFormat(), new Path(path)).build();
        env.fromSource(fileSource, WatermarkStrategy.noWatermarks(), "file").print();

        env.execute();
    }
}