package com.decent.flinkcdc;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @ClassName ConfigurationUtils
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/9/12 11:14
 * @Version 1.0
 */
public class ConfigurationUtils {
    private static Properties properties = new Properties();

    //读取Resource目录下文件
    static {
        InputStream resourceAsStream = ConfigurationUtils.class.getClassLoader().getResourceAsStream("custom.properties");
        try {
            properties.load(resourceAsStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getProperties(String key) {

        return properties.getProperty(key);
    }

    //获取boolean类型的配置项
    public static boolean getBoolean(String key) {
        String myKey = properties.getProperty(key);
        try {
            return Boolean.valueOf(myKey);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}