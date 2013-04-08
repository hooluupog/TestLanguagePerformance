/**
*reflection 实现版本
*性能相比其他的所有版本是最差的.
*在目前没有支持泛型的情况下,根据具体问题实现具体类型的数据结构,
*能获得最好的性能
**/

package main

import (
	"fmt"
	"reflect"
	"time"
)

type Stack struct {
	elem []interface{}
	top  int
}

/*type Element struct {
	value interface{} 
}*/

func (s *Stack) Length() int {
	return s.top
}
func (s *Stack) Push(i interface{}) {
	/* Value represents the run-time data
		ValueOf(i) returns a new Value initialized
		to the concrete value stored in interface i.
		Indirect returns the value that v (Indirect(v Value) Value) points to.
	        that is to say: you can pass the data by reference(the data's pointer value)
	        and then fetch out its value to doing a copy.*/
	v := reflect.Indirect(reflect.ValueOf(i))
	s.elem = append(s.elem[:s.top], v.Interface())
	s.top++
}
func (s *Stack) Pop() (value interface{}) {
	if s.top > 0 {
		s.top--
		value = s.elem[s.top]
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
		*hs = stack.Pop().(HanoiState) //type assertion
		tmp = *hs
		if hs.n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, hs.disk,hs.x,hs.z)
		} else {
			//参考递归版本的实现，这里的顺序和递归函数调用恰好相反的
			*hs = HanoiState{tmp.n - 1, tmp.n - 1, tmp.y, tmp.x, tmp.z}
			stack.Push(hs)
			*hs = HanoiState{1, tmp.n, tmp.x, tmp.y, tmp.z}
			stack.Push(hs)
			*hs = HanoiState{tmp.n - 1, tmp.n - 1, tmp.x, tmp.z, tmp.y}
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
