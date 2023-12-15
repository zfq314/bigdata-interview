package zfq.bigdata.flink.api;

import org.apache.flink.streaming.api.datastream.ConnectedStreams;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.co.CoMapFunction;

/**
 * @ClassName ConnectDemo
 * @Description TODO connect 连接流
 * 为了处理更加灵活，连接操作允许流的数据类型不同。但我们知道一个DataStream中的数据只能有唯一的类型所以连接得到的并不是DataStream，
 * 而是一个“连接流”连接流可以看成是两条流形式上的“统一”，
 * 被放在了一个同一个流中;事实上内部仍保持各自的数据形式不变，彼此之间是相互独立的。
 * 要想得到新的DataStream还需要进一步定义一个“同处理” (co-process)转换操作，
 * 用来说明对于不同来源、不同类型的数据，怎样分别进行处理转换、得到统一的输出类型。
 * 所以整体上来，两条流的连接就像是“一国两制”两条流可以保持各自的数据类型、处理方式也可以不同不过最终还是会统一到同一个DataStream中
 * @Author ZFQ
 * @Date 2023/12/15 15:45
 * @Version 1.0
 */
public class ConnectDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        DataStreamSource<Integer> ds1 = env.fromElements(1, 2, 3);
        DataStreamSource<String> ds2 = env.fromElements("a", "b", "c");
        ConnectedStreams<Integer, String> connectedStreams = ds1.connect(ds2);

        SingleOutputStreamOperator<String> result = connectedStreams.map(new CoMapFunction<Integer, String, String>() {
            @Override
            public String map1(Integer value) throws Exception {
                return "来源于数字流:" + value.toString();
            }

            @Override
            public String map2(String value) throws Exception {
                return "来源于字母流:" + value;
            }
        });
        result.print();

        env.execute();

    }
}