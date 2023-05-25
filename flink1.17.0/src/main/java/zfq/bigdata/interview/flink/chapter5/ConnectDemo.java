package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.streaming.api.datastream.ConnectedStreams;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.co.CoMapFunction;

/**
 * @ClassName ConnectDemo
 * @Description TODO 流的联合虽然简单，不过受限于数据类型不能改变，灵活性大打折扣，所以实际应用较少出现。除了联合（union），Flink还提供了另外一种方便的合流操作——连接（connect）。
 * 1、一次只能连接 2条流
 * 2、流的数据类型可以不一样
 * 3、 连接后可以调用 map、flatmap、process来处理，但是各处理各的
 * @Author ZFQ
 * @Date 2023/5/25 17:28
 * @Version 1.0
 */
public class ConnectDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment().setParallelism(1);

        DataStreamSource<Integer> source1 = env.fromElements(1, 2, 3);
        DataStreamSource<String> source2 = env.fromElements("a", "b", "c");

        ConnectedStreams<Integer, String> connect = source1.connect(source2);

        SingleOutputStreamOperator<String> result = connect.map(new CoMapFunction<Integer, String, String>() {
            @Override
            public String map1(Integer value) throws Exception {
                return "来源于数组流:" + value.toString();
            }

            @Override
            public String map2(String value) throws Exception {
                return "来源于字母流" + value;
            }
        });
        result.print();
        env.execute();
    }
}

    //上面的代码中，ConnectedStreams有两个类型参数，分别表示内部包含的两条流各自的数据类型；由于需要“一国两制”，
    // 因此调用.map()方法时传入的不再是一个简单的MapFunction，而是一个CoMapFunction，表示分别对两条流中的数据执行map操作。
    // 这个接口有三个类型参数，依次表示第一条流、第二条流，以及合并后的流中的数据类型。需要实现的方法也非常直白：
    // .map1()就是对第一条流中数据的map操作，.map2()则是针对第二条流