import java.util.List;
import java.util.Arrays;
import java.util.Collection;
import java.util.Random;
import static java.util.stream.Collectors.*;
import java.lang.StringBuilder;

interface MyList<E>{
    MyList<E> getPart(int fromIndex,int toIndex); 
    int size();
    E set(int index, E element);
    E get(int index);
    void swap(int i,int j);
}

class MyArrayList<E> implements MyList<E>{
    private Object[] elementData;
    private int size;

    public MyArrayList(Collection<? extends E> c) {
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

    public MyList<E> getPart(int fromIndex, int toIndex) {
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

    private class SubList implements MyList<E> {
        private final int offset;
        private int size;

        SubList(int offset,int fromIndex, int toIndex) {
            this.offset = offset + fromIndex;
            this.size = toIndex - fromIndex;
        }

        public E set(int index, E element) {
            rangeCheck(index);
            E oldValue = MyArrayList.this.elementData(offset + index);
            MyArrayList.this.elementData[offset + index] = element;
            return oldValue;
        }

        public E get(int index) {
            rangeCheck(index);
            return MyArrayList.this.elementData(offset + index);
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
            E temp = MyArrayList.this.elementData(offset + i);
            MyArrayList.this.elementData[offset + i] = 
                MyArrayList.this.elementData(offset + j);
            MyArrayList.this.elementData[offset + j] = temp;
        }

        public int size() {
            return this.size;
        }

        public MyList<E> getPart(int fromIndex, int toIndex) {
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

    private static <E extends Comparable<? super E>> void insertSort(MyList<E> a) {
        for (int i = 1; i < a.size(); i++) {
            // 依次将a[1]~a[len-1]插入到前面已排序序列
            E temp = a.get(i); // 暂存a[i]
            int l = 0;
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

    public static <E extends Comparable<? super E>> void sort(MyList<E> s) {
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
        sort(s.getPart(0, pivotIdx));
        sort(s.getPart(pivotIdx + 1, s.size()));
    }

    private static <E extends Comparable<? super E>> int partition(MyList<E> a) {
        int rIndex = new Random().nextInt(2^64-1) % a.size();
        // 将枢值交换到第一个元素
        a.swap(0,rIndex);
        E pivotkey = a.get(0); // 置当前表中第一个元素为枢轴值
        int i = 0;
        for (int j = 1; j < a.size(); j++) {
            // 从第二个元素开始找小于基准的元素
            if (a.get(j).compareTo(pivotkey) < 0) {
                // 找到和交换到前面
                i++;
                a.swap(i,j);
            }
        }
        // 将基准元素插入到最终位置
        a.swap(0,i);
        return i;
    }

    public static void testCreationAndUsage(){
        int length = 1000000;
        List<Long> l = new Random().longs(length,0,length).boxed().collect(toList());
        MyList<Long> ll = new MyArrayList<>(l);
        sort(ll);
    }

    public static void main(String[]args) {
        testCreationAndUsage();
    }
}
