/** 这个程序比hanoi_stack_go1.go和hanoi_stack_go2.go慢的多，原因是更多的函数调
** 用次数和创建结构体数据次数。本质上是更多的访存次数导致cpu有较长的空闲等待时间。
** (1).hannoi_stack.go使用interface{}接收外部数据，在push方法中，
** s.top = &Element{value, s.top}每次都会创建一个新的element，需要访存开辟空间；
** (2).hanoi()方法内部，
**                hs = &HanoiState{tmp.n-1,tmp.n-1,tmp.y,tmp.x,tmp.z}
**                stack.Push(hs)
** 每次都会创新一个新的HanoiState，需要访存开辟空间，然后将该新分配的空间地址入栈。
** 这样，频繁的访存导致了程序的性能降低。,同样相比递归版本的实现，一次循环体内，
** 需要调用1次pop()和3次push()过多的函数调用也会增加访存次数(系统会将函数的首地址
** 和返回地址，相关参数存入栈区内)导致性能下降。
** (3). 在代码片段else循环体内部，以下两种写法的区别：
** hs = &HanoiState{tmp.n-1,tmp.n-1,tmp.y,tmp.x,tmp.z}
** stack.Push(hs)
** ...
** hs为指针，每次会创建一个新的hanoistate，然后hs指向这个地址；
** 
** hs = HanoiState{tmp.n-1,tmp.n-1,tmp.y,tmp.x,tmp.z}
** stack.Push(&hs)
** ...
** hs为一个结构体数据，在初始化时空间和地址已经分配好了，hanoistate{...}为一个临时的数据
** 结构，其值会传给hs，但以后的循环中不会再开辟新的内存空间，而是一直使用这个临时空间，
** 所以，hs的地址始终是不变的。
** 显然，后面的写法访存的次数更少。
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
	tmp := *hs
	stack.Push(hs)
	for stack.Length() > 0 {
		hs = stack.Pop().(*HanoiState) //type assertion
		tmp = *hs
		if hs.n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, hs.disk,hs.x,hs.z)
		} else {
			//参考递归版本的实现，这里的顺序和递归函数调用恰好相反的
			hs = &HanoiState{tmp.n - 1, tmp.n - 1, tmp.y, tmp.x, tmp.z}
			stack.Push(hs)
			hs = &HanoiState{1, tmp.n, tmp.x, tmp.y, tmp.z}
			stack.Push(hs)
			hs = &HanoiState{tmp.n - 1, tmp.n - 1, tmp.x, tmp.z, tmp.y}
			stack.Push(hs)
		}
	}
}

func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Printf(" %vms\n", duration.Seconds()*1000)
}
