import java.util.List;
import java.util.Collections;
import java.util.Random;
import static java.util.stream.Collectors.*;

public class SortWithIndex{
    private static final int INSERTSORT_THRESHOLD = 32;

    private static <E extends Comparable<? super E>> void insertSort(List<E> a, int start,int end) {
        for (int i = start + 1; i <= end; i++) {
            // 依次将a[1]~a[len-1]插入到前面已排序序列
            E temp = a.get(i); // 暂存a[i]
            int l = start;
            int h = i - 1; // 设置折半查找范围
            while (l <= h) {
                // 开始折半查找(升序)
                int mid = (l + h) / 2; // 取中间点
                if (a.get(mid).compareTo(temp) > 0) {
                    // 查找左半子表
                    h = mid - 1;
                } else {
                    // 查找右半子表
                    l = mid + 1;
                }
            }
            for (int j = i - 1; j >= h + 1; j--) {
                // 统一后移元素，空出插入位置
                a.set(j + 1, a.get(j));
            }
            a.set(h + 1, temp); // 插入操作
        }
    }

    public static <E extends Comparable<? super E>> void sort(List<E> s,
            int start,int end) {
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

    private static <E extends Comparable<? super E>> int partition(List<E> a,int start,int end) {
        int length = end - start + 1;
        int rIndex = start + new Random().nextInt(2^64-1) % length;
        // 将枢值交换到第一个元素
        Collections.swap(a,start,rIndex);
        E pivotkey = a.get(start); // 置当前表中第一个元素为枢轴值
        int i = start;
        for (int j = start + 1; j <= end; j++) {
            // 从第二个元素开始找小于基准的元素
            if (a.get(j).compareTo(pivotkey) < 0) {
                // 找到和交换到前面
                i++;
                Collections.swap(a,i,j);
            }
        }
        // 将基准元素插入到最终位置
        Collections.swap(a,start,i);
        return i;
    }

    public static void testCreationAndUsage(){
        int length = 1000000;
        List<Long> l = new Random().longs(length,0,length).boxed().collect(toList());
        sort(l,0,l.size()-1);
    }

    public static void main(String[]args) {
        testCreationAndUsage();
    }
}
