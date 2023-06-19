import junit.framework.TestCase;
public class MyUDFTest extends TestCase {
    public static void main(String[] args) {
        MyUDF myUDF = new MyUDF();

        System.out.println(myUDF.evaluate("zfq"));

        System.out.println(myUDF.evaluate(myUDF.evaluate("zfq"),"hbb"));
    }

}