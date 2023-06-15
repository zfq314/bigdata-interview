package zfq.bigdata.flume;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONException;

/**
 * @ClassName JSONUtils
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/6/15 16:17
 * @Version 1.0
 */
public class JSONUtils {
    public static boolean isJson(String log) {
        try {
            JSON.parseObject(log);
            return true;
        } catch (JSONException e) {
            return false;
        }

    }

}