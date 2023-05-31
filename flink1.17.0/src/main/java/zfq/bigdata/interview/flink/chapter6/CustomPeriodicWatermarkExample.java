package zfq.bigdata.interview.flink.chapter6;


import org.apache.flink.api.common.eventtime.*;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;

/**
 * @ClassName CustomPeriodicWatermarkExample
 * @Description TODO 周期性生成器一般是通过onEvent()观察判断输入的事件，而在onPeriodicEmit()里发出水位线。
 * @Author ZFQ
 * @Date 2023/5/31 9:59
 * @Version 1.0
 */
// 自定义水位线的产生
public class CustomPeriodicWatermarkExample {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        env.addSource(new ClickSource())
                .assignTimestampsAndWatermarks(new CustomWatermarkStrategy())
                .print();

        env.execute();
    }

    public static class CustomWatermarkStrategy implements WatermarkStrategy<Event> {


        @Override
        public TimestampAssigner<Event> createTimestampAssigner(TimestampAssignerSupplier.Context context) {
            return new SerializableTimestampAssigner<Event>() {
                @Override
                public long extractTimestamp(Event element, long recordTimestamp) {
                    // 告诉程序数据源里的时间戳是哪一个字段
                    return element.timestamp;
                }
            };
        }

        @Override
        public WatermarkGenerator<Event> createWatermarkGenerator(WatermarkGeneratorSupplier.Context context) {
            return new CustomBoundedOutOfOrdernessGenerator();
        }


        public static class CustomBoundedOutOfOrdernessGenerator implements WatermarkGenerator<Event> {
            private Long delayTime = 5000L;// 延迟时间
            private Long maxTs = -Long.MAX_VALUE + delayTime + 1L; // 观察到的最大时间戳

            @Override
            public void onEvent(Event event, long eventTimestamp, WatermarkOutput output) {
                // 每来一条数据就调用一次
                Math.max(event.timestamp, maxTs); // 更新最大时间戳

            }

            @Override
            public void onPeriodicEmit(WatermarkOutput output) {
                // 发射水位线，默认200ms调用一次
                output.emitWatermark(new Watermark(maxTs - delayTime - 1L));
            }
        }
    }
}
