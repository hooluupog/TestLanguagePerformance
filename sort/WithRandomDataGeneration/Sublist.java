import java.util.List;
import java.util.Collections;
import java.util.Random;
import static java.util.stream.Collectors.*;

public class Sublist{
    private static final int INSERTSORT_THRESHOLD = 32;

    private static <E extends Comparable<? super E>> void insertSort(List<E> a) {
        for (int i = 1; i < a.size(); i++) {
            // ���ν�a[1]~a[len-1]���뵽ǰ������������
            E temp = a.get(i); // �ݴ�a[i]
            int l = 0;
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

    // Classic quicksort.
    public static <E extends Comparable<? super E>> void sort(List<E> s) {
        int length = s.size();
        if (length <= 1) {
            return;
        }
        if (length <= INSERTSORT_THRESHOLD) {
            insertSort(s);
            return;
        }
        int pivotIdx = partition(s);
        // Java's subList is backed by origin list without copying.
        sort(s.subList(0, pivotIdx));
        sort(s.subList(pivotIdx + 1, s.size()));
    }

    private static <E extends Comparable<? super E>> int partition(List<E> a) {
        int rIndex = new Random().nextInt(2^64-1) % a.size();
        // ����ֵ��������һ��Ԫ��
        Collections.swap(a,0,rIndex);
        E pivotkey = a.get(0); // �õ�ǰ���е�һ��Ԫ��Ϊ����ֵ
        int i = 0;
        for (int j = 1; j < a.size(); j++) {
            // �ӵڶ���Ԫ�ؿ�ʼ��С�ڻ�׼��Ԫ��
            if (a.get(j).compareTo(pivotkey) < 0) {
                // �ҵ��ͽ�����ǰ��
                i++;
                Collections.swap(a,i,j);
            }
        }
        // ����׼Ԫ�ز��뵽����λ��
        Collections.swap(a,0,i);
        return i;
    }

    public static void testCreationAndUsage(){
        int length = 1000000;
        List<Long> l = new Random().longs(length,0,length).boxed().collect(toList());
        sort(l);
    }

    public static void main(String[]args) {
        testCreationAndUsage();
    }
}
