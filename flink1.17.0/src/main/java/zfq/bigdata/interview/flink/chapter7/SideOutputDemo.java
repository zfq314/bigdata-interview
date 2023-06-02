package zfq.bigdata.interview.flink.chapter7;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.api.common.typeinfo.Types;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.KeyedProcessFunction;
import org.apache.flink.util.Collector;
import org.apache.flink.util.OutputTag;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;

/**
 * @ClassName SideOutputDemo
 * @Description TODO 案例需求：对每个传感器，水位超过10的输出告警信息
 * @Author ZFQ
 * @Date 2023/6/2 15:23
 * @Version 1.0
 */
public class SideOutputDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        SingleOutputStreamOperator<WaterSensor> stream = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(WatermarkStrategy
                        .<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                        .withTimestampAssigner((data, ts) -> data.getTs() * 1000L)
                );
        //定义侧输出流
        OutputTag<String> warn = new OutputTag<>("warn", Types.STRING);
        //具体的数据处理
        SingleOutputStreamOperator<WaterSensor> process = stream.keyBy(data -> data.getId())
                .process(new KeyedProcessFunction<String, WaterSensor, WaterSensor>() {
                    @Override
                    public void processElement(WaterSensor value, Context ctx, Collector<WaterSensor> out) throws Exception {
                        //使用侧输出流发出警告
                        if (value.getVc() > 10) {
                            ctx.output(warn, "当前水位=" + value.getVc() + "大于阈值10！！！");
                        }
                        //主流数据正常发送
                        out.collect(value);
                    }
                });
        process.print("主流数据");
        process.getSideOutput(warn).printToErr("warn");


        env.execute();
    }
}