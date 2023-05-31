package zfq.bigdata.interview.flink.chapter7;

import org.apache.flink.api.common.eventtime.WatermarkStrategy;
import org.apache.flink.streaming.api.TimerService;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.functions.KeyedProcessFunction;
import org.apache.flink.util.Collector;
import zfq.bigdata.interview.flink.chapter5.WaterSensor;
import zfq.bigdata.interview.flink.chapter5.WaterSensorMapFunction;

import java.time.Duration;

/**
 * @ClassName KeyedProcessTimerDemo
 * @Description TODO KeyedProcessFunction案例
 * @Author ZFQ
 * @Date 2023/5/31 17:28
 * @Version 1.0
 */
public class KeyedProcessTimerDemo {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.setParallelism(1);

        SingleOutputStreamOperator<WaterSensor> sensorData = env.socketTextStream("hadoop31", 7777)
                .map(new WaterSensorMapFunction())
                .assignTimestampsAndWatermarks(WatermarkStrategy
                        //策略
                        .<WaterSensor>forBoundedOutOfOrderness(Duration.ofSeconds(3))
                        //指定字段
                        .withTimestampAssigner((data, ts) -> data.getTs() * 1000L)
                );
        SingleOutputStreamOperator<String> process = sensorData.keyBy(data -> data.getId())
                .process(new KeyedProcessFunction<String, WaterSensor, String>() {
                    @Override
                    public void processElement(WaterSensor value, Context ctx, Collector<String> out) throws Exception {
                        /**
                         * 来一条数据调用一次
                         * @param value
                         * @param ctx
                         * @param out
                         * @throws Exception
                         */
                        //获取当前的数据
                        String currentKey = ctx.getCurrentKey();
                        //注册定时器
                        TimerService timerService = ctx.timerService();
                        //事件时间的案例
                        Long currentEventTime = ctx.timestamp();// 数据中提取出来的事件时间
                        timerService.registerEventTimeTimer(5000L);
                        System.out.println("当前key=" + currentKey + ",当前时间=" + currentEventTime + ",注册了一个5s的定时器");

                        // 2、处理时间的案例
                        // long currentTs = timerService.currentProcessingTime();
                        // timerService.registerProcessingTimeTimer(currentTs + 5000L);
                        // System.out.println("当前key=" + currentKey + ",当前时间=" + currentTs + ",注册了一个5s后的定时器");

                        // 3、获取 process的 当前watermark
                        long currentWatermark = timerService.currentWatermark();
                        System.out.println("当前数据=" + value + ",当前watermark=" + currentWatermark);

                        // 注册定时器： 处理时间、事件时间
                        // timerService.registerProcessingTimeTimer();
                        // timerService.registerEventTimeTimer();
                        // 删除定时器： 处理时间、事件时间
                        //  timerService.deleteEventTimeTimer();
                        // timerService.deleteProcessingTimeTimer();

                        // 获取当前时间进展： 处理时间-当前系统时间，  事件时间-当前watermark
                        // long currentTs = timerService.currentProcessingTime();
                        // long wm = timerService.currentWatermark();

                    }

                    @Override
                    public void onTimer(long timestamp, OnTimerContext ctx, Collector<String> out) throws Exception {
                        super.onTimer(timestamp, ctx, out);
                        String currentKey = ctx.getCurrentKey();

                        System.out.println("key=" + currentKey + "现在时间是" + timestamp + "定时器触发");
                    }
                });
        process.print();

        env.execute();
    }
}