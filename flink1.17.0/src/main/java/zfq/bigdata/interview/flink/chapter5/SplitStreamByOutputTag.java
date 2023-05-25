package zfq.bigdata.interview.flink.chapter5;

import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SideOutputDataStream;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.ProcessFunction;
import org.apache.flink.util.Collector;
import org.apache.flink.util.OutputTag;

/**
 * @ClassName SplitStreamByOutputTag
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/25 17:02
 * @Version 1.0
 */
public class SplitStreamByOutputTag {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<String> streamSource = env.socketTextStream("hadoop31", 7777);

        SingleOutputStreamOperator<WaterSensor> ds = streamSource.map(new WaterSensorMapFunction());
        //定义侧输出流
        OutputTag<WaterSensor> s1 = new OutputTag<WaterSensor>("s1", Types.POJO(WaterSensor.class)) {
        };
        OutputTag<WaterSensor> s2 = new OutputTag<WaterSensor>("s2", Types.POJO(WaterSensor.class)) {
        };

        //业务逻辑操作,返回的都是主流
        SingleOutputStreamOperator<WaterSensor> ds1 = ds.process(new ProcessFunction<WaterSensor, WaterSensor>() {
            @Override
            public void processElement(WaterSensor value, Context ctx, Collector<WaterSensor> out) throws Exception {
                if ("s1".equals(value.getId())) {
                    ctx.output(s1, value);
                } else if ("s2".equals(value.getId())) {
                    ctx.output(s2, value);
                } else {
                    out.collect(value);
                }
            }
        });
        ds1.print("主流，非s1,s2的传感器");

        SideOutputDataStream<WaterSensor> s1Ds = ds1.getSideOutput(s1);
        SideOutputDataStream<WaterSensor> s2Ds = ds1.getSideOutput(s2);
        s1Ds.printToErr("s1");
        s2Ds.printToErr("s2l");
        env.execute();
    }
}