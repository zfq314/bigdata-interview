package zfq.bigdata.interview.flink.chapter6;


import org.apache.flink.api.common.functions.Partitioner;

/**
 * @ClassName MyPartitioner
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/31 10:34
 * @Version 1.0
 */
public class MyPartitioner implements Partitioner<String> {
    @Override
    public int partition(String key, int numPartitions) {
        return Integer.parseInt(key) % numPartitions;
    }


}