package zfq.bigdata.flink.utils;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

/**
 * @ClassName DataSourceUtils
 * @Description TODO 数据源配置类
 * @Author ZFQ
 * @Date 2023/11/2 10:38
 * @Version 1.0
 */
public class DataSourceUtils implements Serializable {
    //定义DataSource
    private static DataSource dataSource = null;

    //git 上搜索
    static {
        try {
            Properties props = new Properties();
            props.setProperty("url", ConfUtils.getProperties("jdbc.url"));
            props.setProperty("username", ConfUtils.getProperties("jdbc.user"));
            props.setProperty("password", ConfUtils.getProperties("jdbc.password"));
            props.setProperty("initialSize", "5"); //初始化大小
            props.setProperty("maxActive", "10"); //最大连接数
            props.setProperty("minIdle", "5");  //最小连接数
            props.setProperty("maxWait", "60000"); //等待时长
            props.setProperty("timeBetweenEvictionRunsMillis", "2000");//配置多久进行一次检测,检测需要关闭的连接 单位毫秒
            props.setProperty("minEvictableIdleTimeMillis", "600000");//配置连接在连接池中最小生存时间 单位毫秒
            props.setProperty("maxEvictableIdleTimeMillis", "900000"); //配置连接在连接池中最大生存时间 单位毫秒
            props.setProperty("validationQuery", "select 1");
            props.setProperty("testWhileIdle", "true");
            props.setProperty("testOnBorrow", "false");
            props.setProperty("testOnReturn", "false");
            props.setProperty("keepAlive", "true");
            props.setProperty("phyMaxUseCount", "100000");
            //设置驱动的版本
            props.setProperty("driverClassName", "com.mysql.jdbc.Driver");
            dataSource = DruidDataSourceFactory.createDataSource(props);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //提供获取连接的方法
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    //释放资源
    public static void closeResource(ResultSet resultSet, PreparedStatement preparedStatement, Connection connection) {
        //先打开的后关闭
        closeResultSet(resultSet);
        closePreparedStatement(preparedStatement);
        closeConnection(connection);

    }

    private static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static void closePreparedStatement(PreparedStatement preparedStatement) {
        if (preparedStatement != null) {
            try {
                preparedStatement.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static void closeResultSet(ResultSet resultSet) {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}