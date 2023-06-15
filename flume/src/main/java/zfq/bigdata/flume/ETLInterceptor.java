package zfq.bigdata.flume;


import org.apache.flume.Context;
import org.apache.flume.Event;
import org.apache.flume.interceptor.Interceptor;

import java.nio.charset.StandardCharsets;
import java.util.Iterator;
import java.util.List;

/**
 * @ClassName ETLInterceptor
 * @Description TODO Etl拦截器
 * @Author ZFQ
 * @Date 2023/6/15 16:06
 * @Version 1.0
 */
public class ETLInterceptor implements Interceptor {
    //初始化
    @Override
    public void initialize() {

    }

    @Override
    public Event intercept(Event event) {
        //获取数据
        byte[] body = event.getBody();
        String log = new String(body, StandardCharsets.UTF_8);
        //判断是否是json
        boolean json = JSONUtils.isJson(log);
        if (json) {
            return event;
        }

        return null;
    }

    @Override
    public List<Event> intercept(List<Event> events) {
        //把event is null的过滤掉
        Iterator<Event> iterator = events.iterator();
        while (iterator.hasNext()) {
            Event event = iterator.next();
            if (intercept(event) == null) {
                iterator.remove();
            }
        }
        return events;
    }

    @Override
    public void close() {

    }

    //（3）静态内部类，实现Interceptor.Builder
    public static class Builder implements Interceptor.Builder {
        @Override
        public Interceptor build() {
            return new ETLInterceptor();
        }

        @Override
        public void configure(Context context) {

        }
    }
}