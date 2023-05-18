package top.zfq.bigdata.interview.basic;

/**
 * @ClassName MyThread
 * @Description TODO
 * @Author ZFQ
 * @Date 2023/5/18 16:59
 * @Version 1.0
 */
public class MyThread  extends Thread{


    public static void main(String[] args) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                System.out.println("新线程");
            }
        }).start();
    }
    @Override
    public void run() {
        super.run();
    }
}