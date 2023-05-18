package top.zfq.bigdata.interview.basic;

/**
 * @ClassName BasicArray
 * @Description TODO 排序
 * @Author ZFQ
 * @Date 2023/5/18 14:41
 * @Version 1.0
 */
public class BasicArray {
    public static void main(String[] args) {
        int[] randomArray = new int[20];
        for (int i = 0; i < randomArray.length; i++) {
            randomArray[i] = (int) (Math.random() * 100);
        }
        long start = System.currentTimeMillis();
        bubbleSortMethod(randomArray);
        long end = System.currentTimeMillis();
        System.out.println();
        System.out.println("冒泡排序耗时" + (end - start));

        System.out.println();

        long start_select = System.currentTimeMillis();
        selectionSort(randomArray);
        long end_select = System.currentTimeMillis();
        System.out.println();
        System.out.println("选择排序耗时" + (end_select - start_select));

    }

    //定义排序方法
    public static void bubbleSortMethod(int[] arr) {
        int temp;
        System.out.println("排序前:");
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + "\t");

        }
        System.out.println();
        //冒泡排序
        for (int i = 0; i < arr.length - 1; i++) {
            for (int j = 0; j < arr.length - 1 - i; j++) {
                if (arr[j] > arr[j + 1]) {
                    temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
        System.out.println("排序后:");
        for (int i = 0; i < arr.length; i++) {
            System.out.print(arr[i] + "\t");
        }
    }

    public static void selectionSort(int arr[]) {
        String end = "\n";
        int index;
        for (int i = 1; i < arr.length; i++) {
            index = 0;
            for (int j = 1; j <= arr.length - i; j++) {
                if (arr[j] > arr[index]) {
                    index = j;    // 查找最大值
                }
            }
            end = arr[index] + " " + end;    // 定位已排好的数组元素
            int temp = arr[arr.length - i];
            arr[arr.length - 1] = arr[index];
            arr[index] = temp;
            System.out.print("【");
            for (int j = 0; j < arr.length - i; j++) {
                System.out.print(arr[j] + " ");
            }
            System.out.print("】" + end);
        }
    }
}