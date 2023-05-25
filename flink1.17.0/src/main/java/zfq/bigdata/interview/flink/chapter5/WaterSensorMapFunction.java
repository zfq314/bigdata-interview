package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.functions.MapFunction;

/**
 * @ClassName WaterSensorMapFunction
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 15:26
 * @Version 1.0
 */
public class WaterSensorMapFunction implements MapFunction<String, WaterSensor> {
    @Override
    public WaterSensor map(String value) throws Exception {
        String[] data = value.split(",");
        return new WaterSensor(data[0], Long.valueOf(data[1]), Integer.valueOf(data[2]));
    }
}