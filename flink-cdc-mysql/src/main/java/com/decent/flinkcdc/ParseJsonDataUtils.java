package com.decent.flinkcdc;

import com.alibaba.fastjson.JSONObject;

/**
 * @ClassName ParseJsonDataUtils
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/9/12 11:15
 * @Version 1.0
 */
public class ParseJsonDataUtils {
    public static JSONObject getJsonData(String data) {
        try {
            return JSONObject.parseObject(data);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}