package top.zfq.bigdata.interview.basic;

/**
 * @ClassName Test
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/10/27 11:57
 * @Version 1.0
 */
public class Demo {
    public static void main(String[] args) {
        Integer num1 = 200;
        Integer num2 = 200;
        //比较的是地址
        if (num1 !=num2){
            System.out.print(1);
        }else{
            System.out.print(2);
        }
        // equals 比较的是值
        if (!num1.equals(num2)){
            System.out.print(3);
        }else{
            System.out.print(4);
        }
    }
}


