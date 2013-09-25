/** 这个程序比hanoi_stack_go1.go和hanoi_stack_go2.go慢的多，原因是更多的函数调
** 用次数以及大量的创建对象。此外相比递归版本，栈模拟版本速度更慢的原因是：在堆中创建了太多的对象，开销更大，这也导致了GC被频繁调用来回收对象产生延迟。
因此：减少函数调用次数和减少在堆中创建对象的次数是优化程序性能的关键。
** (1).hannoi_stack.go使用interface{}接收外部数据，在push方法中，
** s.top = &Element{value, s.top}(相当于s.top = new(Element),分配相应的存储空间并
** 返回新的地址)每次都会创建一个新的element，需要不断访存开辟空间；
** (2).hanoi()方法内部，
**                stack.Push(&HanoiState{hs.n-1,hs.n-1,hs.y,hs.x,hs.z})
** 每次都会创新一个新的HanoiState，需要访存开辟空间，然后将该新分配的空间地址入栈。
** 这样，频繁的访存导致了程序的性能降低。,同样相比递归版本的实现，一次循环体内，
** 需要调用1次pop()和3次push()过多的函数调用也会增加访存次数(系统会将函数的首地址
** 和返回地址，相关参数存入栈区内)导致性能下降。
** (3). 在代码片段else循环体内部，以下两种写法的区别：
**      (1) stack.Push(&HanoiState{hs.n-1,hs.n-1,hs.y,hs.x,hs.z})
**          每次会创建一个新的hanoistate，然后将这个新的HanoiState的地址入栈；
** 
**      (2) hs = HanoiState{hs.n-1,hs.n-1,hs.y,hs.x,hs.z}
**          stack.Push(&hs)
**           ...
**          hs为一个结构体数据，在初始化时空间和地址已经分配好了，hanoistate{...}为
**          一个临时的数据结构，其值会传给hs，但以后的循环中不会再开辟新的内存空间，
**          而是一直使用这个临时空间，所以，hs的地址始终是不变的。垃圾回收器不会立刻
**          回收HanoiState{...},而是放入缓存便于之后循环体内部其他实例化对象接着使用
**          这块内存.显然，后面的写法访存的次数更少。
**/

package main

import (
	"fmt"
	"time"
)

type Stack struct {
	top  *Element
	size int
}
type Element struct {
	value interface{}
	next  *Element
}

func (s *Stack) Length() int {
	return s.size
}
func (s *Stack) Push(value interface{}) {
	//栈顶指针top指向新创建的element，element的value
	//接收外部的值或地址(the pointer or value wrappered in interface{})
	//next指针保存上一次栈顶指针的位置
	s.top = &Element{value, s.top}
	s.size++
}
func (s *Stack) Pop() (value interface{}) {
	if s.size > 0 {
		value, s.top = s.top.value, s.top.next
		s.size--
		return
	}
	return nil
}

type HanoiState struct {
	n, disk int
	x, y, z byte
}

func hanoi(n int, x byte, y byte, z byte) {
	var count int = 0
	stack := new(Stack)
	hs := &HanoiState{n, n, x, y, z}
	stack.Push(hs)
	for stack.Length() > 0 {
		hs = stack.Pop().(*HanoiState) //type assertion
		if hs.n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, hs.disk, hs.x, hs.z)
		} else {
			//参考递归版本的实现，这里的顺序和递归函数调用恰好相反的
			stack.Push(&HanoiState{hs.n - 1, hs.n - 1, hs.y, hs.x, hs.z})
			stack.Push(&HanoiState{1, hs.n, hs.x, hs.y, hs.z})
			stack.Push(&HanoiState{hs.n - 1, hs.n - 1, hs.x, hs.z, hs.y})
		}
	}
}

func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Printf(" %vms\n", duration.Seconds()*1000)
}
