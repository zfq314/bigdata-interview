package zfq.bigdata.flink.api;

import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.AggregateOperator;
import org.apache.flink.api.java.operators.DataSource;
import org.apache.flink.api.java.operators.FlatMapOperator;
import org.apache.flink.api.java.operators.UnsortedGrouping;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.util.Collector;

/**
 * @ClassName BatchWordCount
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/11/2 11:48
 * @Version 1.0
 */
public class BatchWordCount {
    public static void main(String[] args) throws Exception {
        //创建执行环境
        ExecutionEnvironment env = ExecutionEnvironment.getExecutionEnvironment();
        //读取文件
        String path = BatchWordCount.class.getClassLoader().getResource("custom.properties").getPath();

        DataSource<String> stringDataSource = env.readTextFile(path);
        FlatMapOperator<String, Tuple2<String, Long>> stringTuple2FlatMapOperator = stringDataSource.flatMap(
                new FlatMapFunction<String, Tuple2<String, Long>>() {
                    @Override
                    public void flatMap(String value, Collector<Tuple2<String, Long>> out) throws Exception {
                        String[] s = value.split(" ");
                        for (String s1 : s) {
                            out.collect(Tuple2.of(s1, 1L));
                        }
                    }
                }
        );
        //分组
        UnsortedGrouping<Tuple2<String, Long>> tuple2UnsortedGrouping = stringTuple2FlatMapOperator.groupBy(0);
        //组内聚合统计
        AggregateOperator<Tuple2<String, Long>> sum = tuple2UnsortedGrouping.sum(1);
        sum.print();

    }
}