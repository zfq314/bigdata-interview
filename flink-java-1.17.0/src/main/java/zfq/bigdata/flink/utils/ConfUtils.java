package zfq.bigdata.flink.utils;

import java.io.InputStream;
import java.util.Properties;

/**
 * @ClassName Utils
 * @Description TODO 配置文件读取类
 * @Author ZFQ
 * @Date 2023/11/2 10:20
 * @Version 1.0
 */
public class ConfUtils {

    private static Properties properties = new Properties();

    //读取配置文件,静态代码块
    static {
        try {
            InputStream resourceAsStream = ConfUtils.class.getClassLoader().getResourceAsStream("custom.properties");
            properties.load(resourceAsStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getProperties(String key) {
        return properties.getProperty(key);
    }
}