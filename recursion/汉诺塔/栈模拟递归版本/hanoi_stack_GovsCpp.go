package main

import (
	"fmt"
	"time"
)

type Stack struct {
	state []HanoiState
	top   int
}

func (s *Stack) Length() int {
	return s.top
}
func (s *Stack) Push(value *HanoiState) {
	s.state = append(s.state[:s.top], *value)
	s.top++
}
func (s *Stack) Pop() (value *HanoiState) {
	if s.top > 0 {
		s.top--
		value = &s.state[s.top]
		return
	}
	return
}

type HanoiState struct {
	n, disk int
	x, y, z byte
}

func hanoi(n int, x byte, y byte, z byte) {
	var count int = 0
	stack := new(Stack)
	hs := HanoiState{n, n, x, y, z}
	tmp := hs
	stack.Push(&hs)
	for stack.Length() > 0 {
		hs = *stack.Pop()
		tmp = hs
		if hs.n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, hs.disk,hs.x,hs.z)
		} else {
			hs = HanoiState{tmp.n - 1, tmp.n - 1, tmp.y, tmp.x, tmp.z}
			stack.Push(&hs)
			hs = HanoiState{1, tmp.n, tmp.x, tmp.y, tmp.z}
			stack.Push(&hs)
			hs = HanoiState{tmp.n - 1, tmp.n - 1, tmp.x, tmp.z, tmp.y}
			stack.Push(&hs)
		}
	}
}

func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Println(duration)
}
