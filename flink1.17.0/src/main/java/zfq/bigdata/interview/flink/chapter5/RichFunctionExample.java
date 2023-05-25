package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.functions.RichMapFunction;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName RichFunctionExample
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 16:25
 * @Version 1.0
 */
public class RichFunctionExample {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<Integer> integerDataStreamSource = env.fromElements(1, 2, 3, 4,5,6,7,8,9,10);
        integerDataStreamSource.map(new RichMapFunction<Integer, Integer>() {
            @Override
            public Integer map(Integer value) throws Exception {
                return value + 1;
            }

            @Override
            public void open(Configuration parameters) throws Exception {
                super.open(parameters);
                System.out.println("索引是：" + getRuntimeContext().getIndexOfThisSubtask() + " 的任务的生命周期开始");
            }

            @Override
            public void close() throws Exception {
                super.close();
                System.out.println("索引是：" + getRuntimeContext().getIndexOfThisSubtask() + " 的任务的生命周期结束");
            }
        }).print();
        env.execute();
    }
}