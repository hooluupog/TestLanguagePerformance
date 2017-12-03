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
            // ���ν�a[1]~a[len-1]���뵽ǰ������������
            long temp = a[i]; // �ݴ�a[i]
            int l = start;
            int h = i - 1; // �����۰���ҷ�Χ
            while (l <= h) {
                // ��ʼ�۰����(����)
                int mid = (l + h) / 2; // ȡ�м��
                if (a[mid] > temp) {
                    // ��������ӱ�
                    h = mid - 1;
                } else {
                    // �����Ұ��ӱ�
                    l = mid + 1;
                }
            }
            for (int j = i - 1; j >= h + 1; j--) {
                // ͳһ����Ԫ�أ��ճ�����λ��
                a[j + 1] = a[j];
            }
            a[h + 1] = temp; // �������
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
        // ����ֵ��������һ��Ԫ��
        swap(a,start,rIndex);
        long pivotkey = a[start]; // �õ�ǰ���е�һ��Ԫ��Ϊ����ֵ
        int i = start;
        for (int j = start + 1; j <= end; j++) {
            // �ӵڶ���Ԫ�ؿ�ʼ��С�ڻ�׼��Ԫ��
            if (a[j] < pivotkey) {
                // �ҵ��ͽ�����ǰ��
                i++;
                swap(a,i,j);
            }
        }
        // ����׼Ԫ�ز��뵽����λ��
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
