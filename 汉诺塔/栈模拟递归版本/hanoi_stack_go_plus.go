/**
*hanoi_stack.go.go 改进版
*在hanoi()函数中使用slice,并通过make()方法提前分配了足够的空间,
*这样就减少了访存次数,使得程序性能相比之前有了大的提升
 */

package main

import (
	"fmt"
	"time"
)

type Stack struct {
	elem []Element
	top  int
}

type Element struct {
	value interface{}
}

func (s *Stack) Length() int {
	return s.top
}
func (s *Stack) Push(value interface{}) {
	//每次在elem切片的top位置之后插入新的value(可能为指针也可能为值)
	s.elem = append(s.elem[:s.top], Element{value})
	s.top++
}
func (s *Stack) Pop() (value interface{}) {
	if s.top > 0 {
		s.top--
		value = s.elem[s.top].value
		return
	}
	return nil
}

type HanoiState struct {
	n, disk int
	x, y, z byte
}

const (
	SIZE = 100
)

func hanoi(n int, x byte, y byte, z byte) {
	var count, i int = 0, 0
	stack := new(Stack)
	hs := make([]HanoiState, SIZE)
	hs = append(hs[:i], HanoiState{n, n, x, y, z})
	tmp := hs[i]
	stack.Push(&hs[i])
	i++
	for stack.Length() > 0 {
		tmp = *(stack.Pop().(*HanoiState)) //type assertion
		//每次Pop()之后,i--;每次Push()之后,i++,将pop()掉的
		//空间中的值用新的值覆盖掉并重新指向(push())这块地址,这样可以节省空间
		i--
		if tmp.n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, tmp.disk,tmp.x,tmp.z)
		} else {
			hs = append(hs[:i], HanoiState{tmp.n - 1, tmp.n - 1, tmp.y, tmp.x, tmp.z})
			stack.Push(&hs[i])
			i++
			hs = append(hs[:i], HanoiState{1, tmp.n, tmp.x, tmp.y, tmp.z})
			stack.Push(&hs[i])
			i++
			hs = append(hs[:i], HanoiState{tmp.n - 1, tmp.n - 1, tmp.x, tmp.z, tmp.y})
			stack.Push(&hs[i])
			i++
		}
	}
}

func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Printf(" %vms\n", duration.Seconds()*1000)
}
