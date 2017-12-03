import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.NoSuchElementException;
import java.io.*;

class ListNode<E extends ListNode<E>>{
    LinkList<E> list;
    ListNode<E> prev;
    ListNode<E> next;
}

class LinkList<E extends ListNode<E>> implements Iterable<E>{
    private ListNode<E> head;
    private int len = 0;
    LinkList(){
        head = new ListNode<E>();
        head.list = this;
        head.prev = head.next = head;
    }

    public E getFirst(){
        return (E)head.next;
    }

    public E getLast(){
        return (E)head.prev;
    }

    public boolean isEmpty(){
        return len == 0;
    }

    public int length(){
        return len;
    }

    public void add(E e) {
        // append [e] into LinkList.
        insert(e, head.prev);
    }

    public void addFirst(E e) {
        // add [e] at the first.
        insert(e, head);
    }

    public void insertBefore(E e, E at) {
        //Insert [e] before [at].
        insert(e, at.prev);
    }

    public void insertAfter(E e, E at) {
        //Insert [e] after [at].
        insert(e, at);
    }

    private void insert(E e, ListNode<E> at) {
        if (e.list != null) {
            throw new UnsupportedOperationException("ListNode is already in a LinkList.");
        }
        e.list = this; // Link value into LinkList.
        e.prev = at;
        e.next = at.next;
        at.next = e;
        e.next.prev = e;
        len++;
    }

    public E remove(E e) {
        e.prev.next = e.next;
        e.next.prev = e.prev;
        e.list = null;
        e.prev = e.next = null;
        len--;
        return e;
    }

    public void reverseBetween(int m, int n) {
        if (m < 1 || n > len) {
            throw new IllegalArgumentException(String.format("Index out of bounds. Wrong range (%d,%d)",m,n));
        }
        int cnt = n - m; // 1 <= m <= n <= LinkList.Length
        E start = getFirst();
        for (int i = 1; i < m; i++) {
            //start points to the first node to be reversed.
            start = (E)start.next;
        }
        E end = start;
        while (cnt > 0) {
            // Insert nodes from m to n into list.
            E curr = (E)end.next;
            remove(curr);
            insertBefore(curr, start);
            start = curr;
            cnt--;
        }
    }
    public Iterator<E> iterator(){
        return new LinkListIterator<E>(this);
    }
    // inner class.
    static final class LinkListIterator<E extends ListNode<E>> implements Iterator<E> {
        final private LinkList<E> list;
        private ListNode<E> next;
        LinkListIterator(LinkList<E> L){
            list = L;
            next = L.head.next;
        }

        public boolean hasNext() {
            if(list.isEmpty() || next == list.head) {
                return false;
            }
            return true;
        }
        public E next(){
            if(!this.hasNext()){
                throw new NoSuchElementException();
            }
            E curr = (E)next;
            next = next.next;
            return curr;
        }
    }
    void printList() {
        List<E> l = new ArrayList<E>();
        Iterator<E> iter = this.iterator();
        iter.forEachRemaining(l::add);
        System.out.println(l);
    }
}

//  Here is how to use Intrusive LinkList. E wrapped to ListNode<E>
class Slist<E> extends ListNode {
    E val;
    Slist(E val){this.val = val;};
    @Override
    public String toString() {
        return val.toString();
    }
}

public class IntrusiveList2{
    public static void main(String[]args){
        LinkList L = new LinkList();
        Slist<Integer> elem = new Slist<Integer>(0);
        List<Slist<Integer>> l = new ArrayList<>();
        L.add(elem);
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        String line;
        StringBuilder str = new StringBuilder();
        try{
            while((line = reader.readLine()) != null){
                str.append(line);
                str.append(System.getProperty("line.separator"));
            }
        }catch(IOException e){e.printStackTrace();}
        String[] strArray = str.toString().trim().split("[\\n\\r\\n\\s+]+");
        for(int i = 0;i <strArray.length;i++){
            l.add(new Slist<Integer>(Integer.parseInt(strArray[i])));
        }
        for (Slist<Integer> i : l.subList(0, l.size() / 2)) {
            L.add(i);
        }
        for (Slist<Integer> i : l.subList(l.size() / 2, l.size())) {
            L.addFirst(i);
        }
        L.printList();
        L.reverseBetween(3, 8);
        L.remove(elem);
        L.reverseBetween(1, L.length());
        //L.reverseBetween(0, L.length());
        //remove performance Test.
        int i = l.size() / 2;
        int j = i + 1;
        while (!L.isEmpty()) {
            if (i >= 0) {
                L.remove(l.get(i));
                i--;
            }
            if (j < l.size()) {
                L.remove(l.get(j));
                j++;
            }
        }
    }
}
