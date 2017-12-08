import java.util.List;
import java.util.Arrays;
import java.util.Collection;
import java.util.Random;
import static java.util.stream.Collectors.*;
import java.lang.StringBuilder;

interface ListI<E>{
    ListI<E> getPart(int fromIndex,int toIndex); 
    int size();
    E set(int index, E element);
    E get(int index);
    void swap(int i,int j);
}

class MList<E> implements ListI<E>{
    private Object[] elementData;
    private int size;

    public MList(Collection<? extends E> c) {
        elementData = c.toArray();
        size = elementData.length;
        if (elementData.getClass() != Object[].class)
            elementData = Arrays.copyOf(elementData, size, Object[].class);
    }

    public int size(){
        return size;
    }
    E elementData(int index) {
        return (E) elementData[index];
    }
    public E get(int index) {
        rangeCheck(index);
        return elementData(index);
    }

    public E set(int index, E element) {
        rangeCheck(index);
        E oldValue = elementData(index);
        elementData[index] = element;
        return oldValue;
    }

    public void swap(int i,int j){
        E temp = elementData(i);
        elementData[i] = elementData(j);
        elementData[j] = temp;
    }

    public String toString(){
        StringBuilder sb = new StringBuilder();
        sb.append('[');
        for(int i = 0;i < size-1;i++){
            sb.append(elementData(i));
            sb.append(", ");
        } 
        if (size > 0){
            sb.append(elementData(size-1));
        }
        sb.append(']');
        return sb.toString();
    }

    private void rangeCheck(int index) {
        if (index >= size)
            throw new IndexOutOfBoundsException(outOfBoundsMsg(index));
    }

    private String outOfBoundsMsg(int index) {
        return "Index: "+index+", Size: "+size;
    }

    public ListI<E> getPart(int fromIndex, int toIndex) {
        subListRangeCheck(fromIndex, toIndex, size);
        return new SubList(0,fromIndex, toIndex);
    }

    static void subListRangeCheck(int fromIndex, int toIndex, int size) {
        if (fromIndex < 0)
            throw new IndexOutOfBoundsException("fromIndex = " + fromIndex);
        if (toIndex > size)
            throw new IndexOutOfBoundsException("toIndex = " + toIndex);
        if (fromIndex > toIndex)
            throw new IllegalArgumentException("fromIndex(" + fromIndex +
                    ") > toIndex(" + toIndex + ")");
    }

    private class SubList implements ListI<E> {
        private final int offset;
        private int size;

        SubList(int offset,int fromIndex, int toIndex) {
            this.offset = offset + fromIndex;
            this.size = toIndex - fromIndex;
        }

        public E set(int index, E element) {
            rangeCheck(index);
            E oldValue = MList.this.elementData(offset + index);
            MList.this.elementData[offset + index] = element;
            return oldValue;
        }

        public E get(int index) {
            rangeCheck(index);
            return MList.this.elementData(offset + index);
        }

        public String toString(){
            StringBuilder sb = new StringBuilder();
            sb.append('[');
            int i = offset;
            for(;i < offset + size-1;i++){
                sb.append(elementData(i));
                sb.append(", ");
            } 
            if(size > 0){
                sb.append(elementData(offset + size-1));
            }
            sb.append(']');
            return sb.toString();
        }

        public void swap(int i,int j){
            E temp = MList.this.elementData(offset + i);
            MList.this.elementData[offset + i] = 
                MList.this.elementData(offset + j);
            MList.this.elementData[offset + j] = temp;
        }

        public int size() {
            return this.size;
        }

        public ListI<E> getPart(int fromIndex, int toIndex) {
            subListRangeCheck(fromIndex, toIndex, size);
            return new SubList(offset,fromIndex, toIndex);
        }

        private void rangeCheck(int index) {
            if (index < 0 || index >= this.size)
                throw new IndexOutOfBoundsException(outOfBoundsMsg(index));
        }

    }
}

public class GetPart{
    private static final int INSERTSORT_THRESHOLD = 32;

    private static <E extends Comparable<? super E>> void insertSort3(ListI<E> a) {
        int length = a.size();
        for (int i = 1; i < length; i++) {
            // ���ν�a[1]~a[len-1]���뵽ǰ������������
            E temp = a.get(i); // �ݴ�a[i]
            int l = 0;
            int h = i - 1; // �����۰���ҷ�Χ
            while (l <= h) {
                // ��ʼ�۰����(����)
                int mid = (l + h) / 2; // ȡ�м��
                E vmid = a.get(mid);
                if (vmid.compareTo(temp) > 0) {
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
    public static <E extends Comparable<? super E>> void sort3(ListI<E> s) {
        int length = s.size();
        if (length <= 1) {
            return;
        }
        if (length <= INSERTSORT_THRESHOLD) {
            insertSort3(s);
            return;
        }
        int pivotIdx = partition3(s);
        // Java's subList is backed by origin list without copying.
        sort3(s.getPart(0, pivotIdx));
        sort3(s.getPart(pivotIdx + 1, s.size()));
    }

    private static <E extends Comparable<? super E>> int partition3(ListI<E> a) {
        int length = a.size();
        int rIndex = new Random().nextInt(2^64-1) % length;
        // ����ֵ��������һ��Ԫ��
        a.swap(0,rIndex);
        E pivotkey = a.get(0); // �õ�ǰ���е�һ��Ԫ��Ϊ����ֵ
        int i = 0;
        for (int j = 1; j < a.size(); j++) {
            // �ӵڶ���Ԫ�ؿ�ʼ��С�ڻ�׼��Ԫ��
            E aj = a.get(j);
            if (aj.compareTo(pivotkey) < 0) {
                // �ҵ��ͽ�����ǰ��
                i++;
                a.swap(i,j);
            }
        }
        // ����׼Ԫ�ز��뵽����λ��
        a.swap(0,i);
        return i;
    }

    public static void testCreationAndUsage(){
        int length = 1000000;
        List<Long> l = new Random().longs(length,0,length).boxed().collect(toList());
        ListI<Long> ll = new MList<>(l);
        sort3(ll);
    }

    public static void main(String[]args) {
        testCreationAndUsage();
    }
}