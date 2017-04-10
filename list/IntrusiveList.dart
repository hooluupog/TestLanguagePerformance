import 'dart:io';
import 'dart:convert';

class ListNode<E extends ListNode<E>> {
  LinkList<E> _list; // ListNode's link. If _list == null,ListNode is
  // not Linked in any LinkList.
  ListNode<E> _prev;
  ListNode<E> _next;
  LinkList<E> get list => _list;
}

class LinkList<E extends ListNode<E>> extends Iterable<E> {
  ListNode<E> _head;
  int _len = 0;
  LinkList() {
    _head = new ListNode<E>();
    _head._list = this;
    _head._prev = _head._next = _head;
  }

  bool get isEmpty => _len == 0;
  Iterator<E> get iterator => new _LinkListIterator<E>(this);

  void add(E e) {
    // append [e] into LinkList.
    _insert(e, _head._prev);
  }

  void addFirst(E e) {
    // add [e] at the first.
    _insert(e, _head);
  }

  void insertBefore(E e, E at) {
    //Insert [e] before [at].
    _insert(e, at._prev);
  }

  void insertAfter(E e, E at) {
    //Insert [e] after [at].
    _insert(e, at);
  }

  void _insert(E e, E at) {
    if (e.list != null) {
      throw new StateError('ListNode is already in a LinkList.');
    }
    e._list = this; // Link value into LinkList.
    e._prev = at;
    e._next = at._next;
    at._next = e;
    e._next._prev = e;
    _len++;
  }

  E remove(E e) {
    e._prev._next = e._next;
    e._next._prev = e._prev;
    e._list = e._prev = e._next = null;
    _len--;
    return e;
  }

  void reverseBetween(int m, int n) {
    if (m < 1 || n > _len) {
      throw new ArgumentError('Index out of bounds. Wrong range ($m,$n)');
    }
    var cnt = n - m; // 1 <= m <= n <= LinkList.Length
    var start = first;
    for (var i = 1; i < m; i++) {
      //start points to the first node to be reversed.
      start = start._next;
    }
    var end = start;
    while (cnt > 0) {
      // Insert nodes from m to n into list.
      var curr = end._next;
      remove(curr);
      insertBefore(curr, start);
      start = curr;
      cnt--;
    }
  }
}

class _LinkListIterator<E extends ListNode<E>> implements Iterator<E> {
  final LinkList<E> _list;
  ListNode<E> _next;
  E _curr;
  _LinkListIterator(LinkList<E> L)
      : _list = L,
        _next = L._head._next;

  bool moveNext() {
    if (_list.isEmpty || _next == _list._head) {
      _curr = null;
      return false;
    }
    _curr = _next;
    _next = _next._next;
    return true;
  }

  E get current => _curr;
}

//  Here is how to use Intrusive LinkList. E wrapped to ListNode<E>
class Slist<E> extends ListNode {
  E val;
  Slist([this.val]);
  @override
  String toString() => '${val}';
}

printList(LinkList L) {
  var l = L.map((i) => i.toString()).toList();
  print(l);
}

void main() {
  var L = new LinkList();
  var s = new Slist<num>(0);
  L.add(s);
  var input = new StringBuffer();
  /* At present(SDK version:1.22),stdin.readLineSync() is
   * unbuffered and its performance is poor.So using async
   * functions to read data as follows.
   * Or just create a data file and read from it.
   * var l = new File('in.txt').readAsStringSync().split(" ");
   */
  stdin.transform(ASCII.decoder).listen((data) {
    input.write(data);
  }, onDone: () {// call back function
    var l = input.toString().split(new RegExp("\\s+"));
    for (var i in l.sublist(0, l.length ~/ 2)) {
      L.add(new Slist<num>(num.parse(i)));
    }
    for (var i in l.sublist(l.length ~/ 2, l.length)) {
      L.addFirst(new Slist<num>(num.parse(i)));
    }
    printList(L);
    L.reverseBetween(3, 8);
    L.remove(s);
    L.reverseBetween(1, L.length);
  });
}
