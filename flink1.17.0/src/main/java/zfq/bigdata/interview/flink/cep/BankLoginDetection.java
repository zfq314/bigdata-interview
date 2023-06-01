package zfq.bigdata.interview.flink.cep;

import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.cep.CEP;
import org.apache.flink.cep.PatternSelectFunction;
import org.apache.flink.cep.PatternStream;
import org.apache.flink.cep.pattern.Pattern;
import org.apache.flink.cep.pattern.conditions.IterativeCondition;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.streaming.api.windowing.time.Time;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @ClassName BankLoginDetection
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/6/1 10:03
 * @Version 1.0
 */
public class BankLoginDetection {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

        env.setParallelism(1);
        DataStreamSource<LoginEvent> loginEvents = env.fromElements(
                //登录事件
                new LoginEvent("account1", 1622557860000L, "location1"),
                new LoginEvent("account1", 1622557861000L, "location2"),
                new LoginEvent("account1", 1622557862000L, "location3"),
                new LoginEvent("account1", 1622557868000L, "location4")
        );


        //定义匹配规则
        Pattern<LoginEvent, LoginEvent> loginPattern = Pattern.<LoginEvent>begin("first")
                //迭代条件
                .where(new IterativeCondition<LoginEvent>() {
                    @Override
                    public boolean filter(LoginEvent loginEvent, Context<LoginEvent> context) throws Exception {
                        // 根据需求定义匹配条件，比如时间窗口和登录地点
                        // 在这个例子中，假设异常登录是指在5分钟内出现了3次登录，并且登录地点不同
                        // 可根据实际需求进行修改
                        Iterable<LoginEvent> events = context.getEventsForPattern("first");
                        if (events.spliterator().estimateSize() < 3) {
                            return false;
                        }
                        // 统计登录地点的不同数量
                        Set<String> locations = new HashSet<>();
                        for (LoginEvent event : events) {
                            locations.add(event.getLocation());
                        }
                        return locations.size() == events.spliterator().estimateSize();
                    }
                })
                .within(Time.minutes(5));
        //在登录事件数据流上应用模式匹配
        PatternStream<LoginEvent> patternStream = CEP.pattern(
                loginEvents
                        .keyBy(LoginEvent::getAccountId) //:: foreach循环
                , loginPattern);

        // 处理匹配事件
        SingleOutputStreamOperator<Tuple2<String, Integer>> result = patternStream.select(new PatternSelectFunction<LoginEvent, Tuple2<String, Integer>>() {
            @Override
            public Tuple2<String, Integer> select(Map<String, List<LoginEvent>> map) throws Exception {
                String accountId = map.get("first").get(0).getAccountId();
                int loginCount = map.get("first").size();
                return Tuple2.of(accountId, loginCount);

            }
        });
        System.out.println("----------------------------");
        result.print();
        result.printToErr();
        System.out.println("----------------------------");
        env.execute("Bank Login Detection");

    }


    // 定义登录事件类型
    public static class LoginEvent {
        private String accountId;
        private long timestamp;
        private String location;

        //有参构造器
        public LoginEvent(String accountId, long timestamp, String location) {
            this.accountId = accountId;
            this.timestamp = timestamp;
            this.location = location;
        }

        //无参构造器
        public LoginEvent() {
        }

        public String getAccountId() {
            return accountId;
        }

        public long getTimestamp() {
            return timestamp;
        }

        public String getLocation() {
            return location;
        }

        public void setAccountId(String accountId) {
            this.accountId = accountId;
        }

        public void setTimestamp(long timestamp) {
            this.timestamp = timestamp;
        }

        public void setLocation(String location) {
            this.location = location;
        }

        @Override
        public String toString() {
            return "LoginEvent{" +
                    "accountId='" + accountId + '\'' +
                    ", timestamp=" + timestamp +
                    ", location='" + location + '\'' +
                    '}';
        }
    }
}