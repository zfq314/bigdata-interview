package zfq.bigdata.interview.flink.chapter2;


import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.java.ExecutionEnvironment;
import org.apache.flink.api.java.operators.AggregateOperator;
import org.apache.flink.api.java.operators.DataSource;
import org.apache.flink.api.java.operators.FlatMapOperator;
import org.apache.flink.api.java.operators.UnsortedGrouping;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.util.Collector;

import javax.annotation.Resources;

/**
 * @ClassName BatchWordCount
 * @Description TODO 批处理程序
 * @Author ZFQ
 * @Date 2023/5/23 17:12
 * @Version 1.0
 */
public class BatchWordCount {
    public static void main(String[] args) throws Exception {
        //获取执行环境
        // Configuration configuration = new Configuration();
        //  configuration.setInteger("rest.port", 8081);
        // 设置final参数，不可以改变参数x的值
        //   public ExecutionEnvironment(final Configuration configuration) {
        //        this(configuration, null);
        //    }
        ExecutionEnvironment executionEnvironment = ExecutionEnvironment.getExecutionEnvironment();
        //读取文件
        String path = Resources.class.getResource("/words.txt").getPath();
        DataSource<String> stringDataSource = executionEnvironment.readTextFile(path);
        FlatMapOperator<String, Tuple2<String, Long>> stringTuple2FlatMapOperator = stringDataSource.flatMap(new FlatMapFunction<String, Tuple2<String, Long>>() {
            @Override
            public void flatMap(String s, Collector<Tuple2<String, Long>> out) throws Exception {
                String[] words = s.split(" ");
                for (String word : words) {
                    out.collect(Tuple2.of(word, 1L));
                }
            }
        });
        //分组
        UnsortedGrouping<Tuple2<String, Long>> tuple2UnsortedGrouping = stringTuple2FlatMapOperator.groupBy(0);
        //分组内聚合统计
        AggregateOperator<Tuple2<String, Long>> sum = tuple2UnsortedGrouping.sum(1);
        //打印
        sum.print();

    }
}