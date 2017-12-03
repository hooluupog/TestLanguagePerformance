import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
import java.util.Random;

public class Sort2{
    private static final int INSERTSORT_THRESHOLD = 10;

    private static void swap(long[] a,int i,int j){
        long temp = a[i];
        a[i] = a[j];
        a[j] = temp;
    }

    private static void insertSort(long[] a,int start,int end) {
        for (int i = start + 1; i <= end; i++) {
            // 依次将a[1]~a[len-1]插入到前面已排序序列
            long temp = a[i]; // 暂存a[i]
            int l = start;
            int h = i - 1; // 设置折半查找范围
            while (l <= h) {
                // 开始折半查找(升序)
                int mid = (l + h) / 2; // 取中间点
                if (a[mid] > temp) {
                    // 查找左半子表
                    h = mid - 1;
                } else {
                    // 查找右半子表
                    l = mid + 1;
                }
            }
            for (int j = i - 1; j >= h + 1; j--) {
                // 统一后移元素，空出插入位置
                a[j + 1] = a[j];
            }
            a[h + 1] = temp; // 插入操作
        }
    }

    // Classic quicksort.
    public static void sort(long[] s,int start,int end) {
        int length = end - start + 1;
        if (length <= 1) {
            return;
        }
        if (length <= INSERTSORT_THRESHOLD) {
            insertSort(s,start,end);
            return;
        }
        int pivotIdx = partition(s,start,end);
        sort(s,start,pivotIdx-1);
        sort(s,pivotIdx + 1, end);
    }

    private static int partition(long[] a,int start,int end) {
        int length = end - start + 1;
        int rIndex = start + (new Random()).nextInt(2^64-1) % length;
        // 将枢值交换到第一个元素
        swap(a,start,rIndex);
        long pivotkey = a[start]; // 置当前表中第一个元素为枢轴值
        int i = start;
        for (int j = start + 1; j <= end; j++) {
            // 从第二个元素开始找小于基准的元素
            if (a[j] < pivotkey) {
                // 找到和交换到前面
                i++;
                swap(a,i,j);
            }
        }
        // 将基准元素插入到最终位置
        swap(a,start,i);
        return i;
    }
    public static void main(String[]args) {
        List<Long> l = new ArrayList<>();
        Scanner scan = new Scanner(System.in);
        while(scan.hasNextLong()){
            l.add(scan.nextLong());
        }
        long a[] = l.stream().mapToLong(i -> i).toArray();
        long b[] = Arrays.copyOf(a,a.length);
        long start = System.currentTimeMillis();
        Arrays.sort(a);
        long end = System.currentTimeMillis();
        System.out.println("time used: " + (end - start) + "ms");
        start = System.currentTimeMillis();
        sort(b,0,b.length-1);
        end = System.currentTimeMillis();
        System.out.println("time used: " + (end - start) + "ms");
    }
}
