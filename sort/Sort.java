import java.util.List;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.Collections;
import java.util.Random;

public class Sort{
    private static final int INSERTSORT_THRESHOLD = 10;
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
        if (s.size() <= 1) {
            return;
        }
        if (s.size() <= INSERTSORT_THRESHOLD) {
            insertSort(s);
            return;
        }
        int pivotIdx = partition(s);
        sort(s.subList(0, pivotIdx));
        sort(s.subList(pivotIdx + 1, s.size()));
    }

    private static <E extends Comparable<? super E>> int partition(List<E> a) {
        int rIndex = (new Random()).nextInt(2^64-1) % a.size();
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
    public static void main(String[]args) {
        List<Long> l = new ArrayList<>();
        Scanner scan = new Scanner(System.in);
        while(scan.hasNextLong()){
            l.add(scan.nextLong());
        }
        List<Long> ll = new ArrayList<>(l);
        long start = System.currentTimeMillis();
        l.sort((a,b) -> a.compareTo(b));
        long end = System.currentTimeMillis();
        System.out.println("time used: " + (end - start) + "ms");
        start = System.currentTimeMillis();
        sort(ll);
        end = System.currentTimeMillis();
        System.out.println("time used: " + (end - start) + "ms");
    }
}
