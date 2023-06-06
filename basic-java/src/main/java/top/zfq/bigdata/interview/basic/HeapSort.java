package top.zfq.bigdata.interview.basic;

/**
 * @ClassName HeapSort
 * @Description TODO 堆排序
 * @Author ZFQ
 * @Date 2023/6/6 17:58
 * @Version 1.0
 */
public class HeapSort {
    public static void heapSort(int[] arr) {
        int n = arr.length;

        // 构建最大堆
        for (int i = n / 2 - 1; i >= 0; i--) {
            heapify(arr, n, i);
        }

        // 逐步将堆顶元素（最大值）与未排序部分的最后一个元素交换，并重新调整堆
        for (int i = n - 1; i >= 0; i--) {
            // 将堆顶元素与未排序部分的最后一个元素交换
            int temp = arr[0];
            arr[0] = arr[i];
            arr[i] = temp;

            // 调整堆
            heapify(arr, i, 0);
        }
    }

    private static void heapify(int[] arr, int n, int i) {
        int largest = i; // 假设父节点是最大值
        int left = 2 * i + 1; // 左子节点索引
        int right = 2 * i + 2; // 右子节点索引

        // 比较左子节点与父节点
        if (left < n && arr[left] > arr[largest]) {
            largest = left;
        }

        // 比较右子节点与父节点
        if (right < n && arr[right] > arr[largest]) {
            largest = right;
        }

        // 如果最大值不是父节点，则交换父节点与最大值，并递归调整子树
        if (largest != i) {
            int swap = arr[i];
            arr[i] = arr[largest];
            arr[largest] = swap;

            heapify(arr, n, largest);
        }
    }

    public static void main(String[] args) {
        int[] arr = {64, 25, 12, 22, 11};
        heapSort(arr);
        System.out.println("排序后的数组：");
        for (int num : arr) {
            System.out.print(num + " ");
        }
    }
}
