abstract class ListNode<E extends ListNode<E>>{
    LinkList<E> _list;  // ListNode's link. If _list == null,ListNode is
    // not Linked in any LinkList.
    ListNode<E> _prev;
    ListNode<E> _next;
    LinkList<E> get list => _list;
}

class LinkList<E extends ListNode<E>> extends Iterable<E>{
    ListNode<E> _first;
    int _length = 0;
    LinkList();

    bool get isEmpty => _length == 0;
    Iterator<E> get iterator => new _LinkListIterator<E>(this);

    void add(E value){ // append [value] into LinkList.
        _insertBefore(_first,value,updateFirst : false);
    }

    void addFirst(E value){ // add [value] at the head of LinkList. 
        _insertBefore(_first,value,updateFirst : true);
    }

    void _insertBefore(E next, E value,{bool updateFirst}){
        if(value.list != null){
            throw new StateError('ListNode is already in a LinkList.');
        }
        value._list = this; // Link value into LinkList.
        if(isEmpty){
            value._prev = value._next = value;
            _first = value;
        }else{
            E pre = next._prev;
            next._prev = value;
            value._prev = pre;
            value._next = next;
            pre._next = value;
            if(updateFirst){
                _first = value;
            }
        }
        _length++;
    }

    // Drop [value] 's link from LinkList.
    void _unlink(E value){
        E next = value._prev._next = value._next;
        value._next._prev = value._prev;
        value._list = value._prev = value._next = null;
        _length--;
        if(isEmpty){
            _first = null;
        }else if (value == _first){
            _first = next;
        }
    }

    bool remove(E value){
        if(value.list != this) { return false; }
        value._list = null; // Unlink value from LinkList.
        _unlink(value);
        return true;
    }

    void reverseBetween(int m, int n) {
        if (m < 1 || n > _length){ 
            throw new ArgumentError('Index out of bounds. Wrong range ($m,$n)'); 
        }
        var cnt = n - m; // 1 <= m <= n <= LinkList.Length
        E p,q;
        var recovery = false;
        var head = _first;
        p = _first;
        for (var i = 1; i < m; i++) { // p point to the first node to be reversed.
            p = p._next;
        }
        if (p != _first) { 
            recovery = true; // Need do head node recovering.
        }
        var next = p;
        while (cnt > 0) { // insert nodes from m to n into list.
            q = p._next;
            _unlink(q);
            _insertBefore(next,q,updateFirst : true);
            next = q;
            cnt--;
        }
        if (recovery) { 
            _first = head; // head node recovery.
        }
    }
}

class _LinkListIterator<E extends ListNode<E>> implements Iterator<E>{
    final LinkList<E> _list;
    ListNode<E> _next;
    E _current;
    bool _visitedFirst;
    _LinkListIterator(LinkList<E> L) 
        : _list = L,
        _next = L._first,
        _visitedFirst = false;

    bool moveNext(){
        if(_list.isEmpty || (_visitedFirst && _next == _list.first)){
            _current = null;
            return false;
        }
        _current = _next;
        _next = _next._next;
        _visitedFirst = true;
        return true;
    }
    E get current => _current;
}

//  Here is how to use Intrusive LinkList. E wrapped to ListNode<E>
class Slist<E> extends ListNode{
    E val;
    Slist([this.val]);
    @override
    String toString() => '${val}';
}

printList(LinkList L){
    var l = L.map((i) => i.toString()).toList();
    print(l);
}

void main(){
    var l = [1.2,2.3,3.4,4.5,5.6,4,0,5.0,2,8,9];
    var L = new LinkList();
    var s = new Slist<num>(0);
    L.add(s);
    for (var i in l.sublist(0,l.length ~/ 2)){
        L.add(new Slist<num>(i));
    }
    for (var i in l.sublist(l.length ~/ 2,l.length)){
        L.addFirst(new Slist<num>(i));
    }
    printList(L);
    L.reverseBetween(3,8);
    printList(L);
    L.remove(s);
    printList(L);
    print('first = ${L.first} last = ${L.last} length = ${L.length}');
    var nl = L.where((i) => num.parse(i.toString()) < 7)
        .map((i) => i.toString()).toList();
    print(nl);
    nl.sort((a,b) => a.compareTo(b));
    print(nl);
    L.reverseBetween(1,L.length);
    printList(L);
    try{
        L.reverseBetween(0,L.length); // Expected error.
    } on ArgumentError catch(e){
        print('Expected fail. ${e.message}');
    }
}
