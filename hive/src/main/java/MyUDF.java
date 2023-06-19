import org.apache.hadoop.hive.ql.exec.UDF;

/**
 * @ClassName MyUDF
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/6/19 10:45
 * @Version 1.0
 */

//UDF
//（1）UDF继承 org.apache.hadoop.hive.ql.exec.UDF
//
//（2）需要实现 evaluate 函数；evaluate 函数支持重载；
//
//（3）在集群使用（将jar包放到hive的lib包下）
//
//          添加 jar
//
//         创建 function(可以创建临时使用)
//
//         使用 function
//
//          删除function
//UDF（User-Defined-Function）函数，一进一出
//
//注意事项：UDF 必须要有返回类型，可以返回 null，但是返回类型不能为 void

public class MyUDF extends UDF {

    //一个入参
    public String evaluate(String str1) {
        return str1.toUpperCase();
    }

    //2个入参
    public String evaluate(String data, String data2) {
        return data.toLowerCase() + data2.toUpperCase();
    }

}