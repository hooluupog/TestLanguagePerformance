package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type item interface {
	Get() *Elem
}

type Elem struct {
	list *List
	pre  item
	next item
}

func (e *Elem) Get() *Elem { return e }

func (e *Elem) Prev() item {
	if p := e.pre; e.list != nil && p != e.list.head {
		return p
	}
	return nil
}

func (e *Elem) Next() item {
	if p := e.next; e.list != nil && p != e.list.head {
		return p
	}
	return nil
}

type List struct {
	head item
	len  int
}

func (l *List) Init() *List { // Init list l with head node.
	elem := Elem{list: l}
	l.head = &elem
	elem.pre, elem.next = l.head, l.head
	l.len = 0
	return l
}

func New() *List { return new(List).Init() }

func (l *List) Len() int {
	return l.len
}

func (l *List) String() string {
	var buf bytes.Buffer
	for e := l.First(); e != nil; e = e.Get().Next() {
		buf.WriteString(fmt.Sprintf("%v ", e))
	}
	return fmt.Sprintf("[%s]", strings.Trim(buf.String(), " "))
}

func (l *List) First() item { // return first node.
	if l.Len() == 0 {
		return nil
	}
	return l.head.Get().next
}

func (l *List) Last() item {
	if l.Len() == 0 {
		return nil
	}
	return l.head.Get().pre
}

func (l *List) Add(elem item) { // append [elem] into LinkList.
	l.insert(elem, l.head.Get().pre)
}

func (l *List) AddFirst(elem item) { // add [elem] at the first.
	l.insert(elem, l.head)
}

func (l *List) InsertBefore(elem item, at item) { //Insert [elem] before [at].
	l.insert(elem, at.Get().pre)
}

func (l *List) InsertAfter(elem item, at item) { //Insert [elem] after [at].
	l.insert(elem, at)
}

func (l *List) insert(elem item, at item) {
	if elem.Get().list != nil {
		panic("Element is already in a list.")
	}
	e, a := elem.Get(), at.Get()
	e.list = l // Link elem into list.
	e.pre = at
	e.next = a.next
	a.next = elem
	e.next.Get().pre = elem
	l.len++
}

func (l *List) Remove(elem item) item {
	e := elem.Get()
	e.list = nil // unlink elem from list.
	e.pre.Get().next = e.next
	e.next.Get().pre = e.pre
	e.pre = nil
	e.next = nil
	e.list = nil
	l.len--
	return elem
}

func (l *List) ReverseBetween(m, n int) {
	if m < 1 || n > l.Len() {
		panic(fmt.Sprintf("Index out of bounds.Wrong range (%d,%d).", m, n))
	}
	cnt := n - m
	start := l.First()
	for i := 1; i < m; i++ { //start points to the first node to be reversed.
		start = start.Get().Next()
	}
	end := start
	for cnt > 0 { // Insert nodes from m to n into list.
		curr := end.Get().Next()
		l.Remove(curr)
		l.InsertBefore(curr, start)
		start = curr
		cnt--
	}
}

// Here is how to use intrusive linked list :
// 1) Define Data struct embedded Elem;
// 2) Implement item interface.

type E struct {
	val interface{}
	Elem
}

func (e *E) Get() *Elem { return &e.Elem }

func (e *E) String() string {
	return fmt.Sprintf("%v", e.val)
}

//////////////////////////////////////////////////////////////

func toSlice(L *List) []float64 {
	var res []float64
	for e := L.First(); e != nil; e = e.Get().Next() {
		res = append(res, e.(*E).val.(float64))
	}
	return res
}

func main() {
	var l []*E
	L := New()
	e := &E{val: float64(0)}
	L.Add(e)
	w := bufio.NewWriter(os.Stdout)
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)
	for scanner.Scan() {
		f, _ := strconv.ParseFloat(scanner.Text(), 64)
		l = append(l, &E{val: f})
	}
	for _, v := range l[0 : len(l)/2] {
		L.Add(v)
	}
	for _, v := range l[len(l)/2 : len(l)] {
		L.AddFirst(v)
	}
	fmt.Fprintln(w, L)
	w.Flush()
	L.ReverseBetween(3, 8)
	L.Remove(e)
	L.ReverseBetween(1, L.Len())
	//remove performance Test.
	i := len(l) / 2
	j := i + 1
	for L.Len() != 0 {
		if i >= 0 {
			L.Remove(l[i])
			i--
		}
		if j < len(l) {
			L.Remove(l[j])
			j++
		}
	}
}
