package main

import (
	"fmt"
	"time"
)

const MAX_SIZE = 100

type Stack struct {
	n, disk [MAX_SIZE]int
	x, y, z [MAX_SIZE]byte
	top     int
}

func (s *Stack) Push(n, disk int, x, y, z byte) {
	s.n[s.top], s.disk[s.top], s.x[s.top], s.y[s.top], s.z[s.top] = n, disk, x, y, z
	s.top++
}
func (s *Stack) Pop() (n, disk int, x, y, z byte) {
	s.top--
	n, disk, x, y, z = s.n[s.top], s.disk[s.top], s.x[s.top], s.y[s.top], s.z[s.top]
	return
}
func (s *Stack) IsEmpty() bool {
	if s.top == 0 {
		return true
	}
	return false
}

func hanoi(n int, x, y, z byte) {
	var count int = 0
	stack := new(Stack)
	stack.Push(n, n, x, y, z)
	for !stack.IsEmpty() {
		tmp_n, _, tmp_x, tmp_y, tmp_z := stack.Pop()
		if tmp_n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, tmp_disk, tmp_x, tmp_z)
		} else {
			stack.Push(tmp_n-1, tmp_n-1, tmp_y, tmp_x, tmp_z)
			stack.Push(1, tmp_n, tmp_x, tmp_y, tmp_z)
			stack.Push(tmp_n-1, tmp_n-1, tmp_x, tmp_z, tmp_y)
		}
	}
}

func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Println(duration)
}
