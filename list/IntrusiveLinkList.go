package main

import (
	"fmt"
	"sort"
	"strconv"
)

type Elem struct {
	list *List
	pre  item
	next item
}

func (e *Elem) Prev() item {
	if p := e.pre; e.list != nil && p != e.list.first {
		return p
	}
	return nil
}

func (e *Elem) Next() item {
	if p := e.next; e.list != nil && p != e.list.first {
		return p
	}
	return nil
}

type List struct {
	first  item
	length int
}

func (l *List) IsEmpty() bool {
	return l.length == 0
}

func (l *List) Len() int {
	return l.length
}

type item interface {
	Get() *Elem
}

func (l *List) First() item { // return head node.
	if l.Len() == 0 {
		return nil
	}
	return l.first
}

func (l *List) Last() item {
	if l.Len() == 0 {
		return nil
	}
	return l.first.Get().pre
}

func (l *List) Add(elem item) { // append [elem] into LinkList.
	l.insertBefore(l.first, elem, false)
}

func (l *List) AddFirst(elem item) { // add [elem] at the head of LinkList.
	l.insertBefore(l.first, elem, true)
}

func (l *List) insertBefore(next item, elem item, updateFirst bool) {
	if elem.Get().list != nil {
		panic("Element is already in a list.")
	}
	elem.Get().list = l // Link elem into list.
	if l.IsEmpty() {
		elem.Get().pre = elem
		elem.Get().next = elem
		l.first = elem
	} else {
		prev := next.Get().pre
		next.Get().pre = elem
		elem.Get().pre = prev
		elem.Get().next = next
		prev.Get().next = elem
		if updateFirst {
			l.first = elem
		}
	}
	l.length++
}

// Drop [elem] 's link from LinkList.
func (l *List) unlink(elem item) {
	e := elem.Get()
	next := e.next
	e.pre.Get().next = e.next
	e.next.Get().pre = e.pre
	e.pre = e.next
	e.list = nil
	l.length--
	if l.IsEmpty() {
		l.first = nil
	} else if elem == l.first {
		l.first = next
	}
}

func (l *List) Remove(elem item) bool {
	e := elem.Get()
	if e.list != l {
		return false
	}
	e.list = nil // unlink elem from list.
	l.unlink(elem)
	return true
}

func (l *List) ReverseBetween(m, n int) {
	if m < 1 || n > l.length {
		panic(fmt.Sprintf("Index out of bounds.Wrong range (%d,%d).", m, n))
	}
	cnt := n - m
	recovery := false
	head := l.first
	p := l.first
	for i := 1; i < m; i++ { // p points to the first node to be reversed.
		p = p.Get().next
	}
	if p != l.first {
		recovery = true // Need do head node recovery
	}
	next := p
	for cnt > 0 { // Insert nodes from m to n into list.
		q := p.Get().next
		l.unlink(q)
		l.insertBefore(next, q, true)
		next = q
		cnt--
	}
	if recovery {
		l.first = head // head node recovery.
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

//////////////////////////////////////////////////////////////
func ToString(l *List) string {
	var s string
	for e := l.First(); e != nil; e = e.Get().Next() {
		s += strconv.FormatFloat(e.(*E).val.(float64), 'g', -1, 64) + " "
	}
	return s
}

func toSlice(L *List) []float64 {
	var res []float64
	for e := L.First(); e != nil; e = e.Get().Next() {
		res = append(res, e.(*E).val.(float64))
	}
	return res
}

func main() {
	l := []float64{1.2, 2.3, 3.4, 4.5, 5.6, 4, 0, 5.0, 2, 8, 9}
	L := new(List)
	e := &E{val: float64(0)}
	L.Add(e)
	for _, v := range l[0 : len(l)/2] {
		L.Add(&E{val: float64(v)})
	}
	for _, v := range l[len(l)/2 : len(l)] {
		L.AddFirst(&E{val: float64(v)})
	}
	fmt.Println(ToString(L))
	L.ReverseBetween(3, 8)
	fmt.Println(ToString(L))
	L.Remove(e)
	fmt.Println(ToString(L))
	fmt.Printf("first = %v last = %v length = %v \n", L.First().(*E).val, L.Last().(*E).val, L.Len())
	nl := toSlice(L)
	var sl []float64
	for _, v := range nl {
		if v < float64(7) {
			sl = append(sl, v)
		}
	}
	fmt.Println(sl)
	sort.Slice(sl, func(i, j int) bool { return sl[i] < sl[j] })
	fmt.Println(sl)
	L.ReverseBetween(1, L.Len())
	fmt.Println(ToString(L))
	L.ReverseBetween(0, L.Len()) // Expected error.
}
