import java.util.List;
import java.util.Collections;
import java.util.Random;
import static java.util.stream.Collectors.*;

public class SortWithIndex{
    private static final int INSERTSORT_THRESHOLD = 32;

    private static <E extends Comparable<? super E>> void insertSort(List<E> a, int start,int end) {
        for (int i = start + 1; i <= end; i++) {
            // ���ν�a[1]~a[len-1]���뵽ǰ������������
            E temp = a.get(i); // �ݴ�a[i]
            int l = start;
            int h = i - 1; // �����۰���ҷ�Χ
            while (l <= h) {
                // ��ʼ�۰����(����)
                int mid = (l + h) / 2; // ȡ�м��
                if (a.get(mid).compareTo(temp) > 0) {
                    // ��������ӱ�
                    h = mid - 1;
                } else {
                    // �����Ұ��ӱ�
                    l = mid + 1;
                }
            }
            for (int j = i - 1; j >= h + 1; j--) {
                // ͳһ����Ԫ�أ��ճ�����λ��
                a.set(j + 1, a.get(j));
            }
            a.set(h + 1, temp); // �������
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
        // ����ֵ��������һ��Ԫ��
        Collections.swap(a,start,rIndex);
        E pivotkey = a.get(start); // �õ�ǰ���е�һ��Ԫ��Ϊ����ֵ
        int i = start;
        for (int j = start + 1; j <= end; j++) {
            // �ӵڶ���Ԫ�ؿ�ʼ��С�ڻ�׼��Ԫ��
            if (a.get(j).compareTo(pivotkey) < 0) {
                // �ҵ��ͽ�����ǰ��
                i++;
                Collections.swap(a,i,j);
            }
        }
        // ����׼Ԫ�ز��뵽����λ��
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
