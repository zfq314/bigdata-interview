package top.zfq.bigdata.interview.basic;

/**
 * @ClassName SelectionSort
 * @Description TODO 选择排序
 * @Author ZFQ
 * @Date 2023/6/6 17:55
 * @Version 1.0
 */
public class SelectionSort {
    public static void selectionSort(int[] arr) {
        int n = arr.length;

        // 遍历数组
        for (int i = 0; i < n - 1; i++) {
            int minIndex = i;

            // 在未排序部分找到最小元素的索引
            for (int j = i + 1; j < n; j++) {
                if (arr[j] < arr[minIndex]) {
                    minIndex = j;
                }
            }

            // 将最小元素与未排序部分的第一个元素交换位置
            int temp = arr[minIndex];
            arr[minIndex] = arr[i];
            arr[i] = temp;
        }
    }

    public static void main(String[] args) {
        int[] arr = {64, 25, 12, 22, 11};
        long start = System.currentTimeMillis();
        selectionSort(arr);
        long end = System.currentTimeMillis();
        System.out.println(end-start);
        System.out.println("排序后的数组：");
        for (int num : arr) {
            System.out.print(num + " ");
        }
    }
}
