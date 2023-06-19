import org.apache.hadoop.hive.ql.exec.UDAF;
import org.apache.hadoop.hive.ql.exec.UDAFEvaluator;
import org.apache.hadoop.io.IntWritable;

/**
 * @ClassName MaxValueUDAF
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/6/19 11:28
 * @Version 1.0
 */
public class MaxValueUDAF extends UDAF {
    public static class MaximumIntUDAFEvaluator implements UDAFEvaluator {
        private IntWritable result;

        public void init() {
            result = null;
        }

        public boolean iterate(IntWritable value) {
            if (value == null) {
                return true;
            }
            if (result == null) {
                result = new IntWritable(value.get());
            } else {
                result.set(Math.max(result.get(), value.get()));
            }
            return true;
        }

        public IntWritable terminatePartial() {
            return result;
        }

        public boolean merge(IntWritable other) {
            return iterate(other);
        }

        public IntWritable terminate() {
            return result;
        }
    }

}