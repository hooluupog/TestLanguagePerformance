/**
* use slice to simulate stack
* push()    a = append(a,x)
* pop()     x, a = a[len(a)-1],a[:len(a)-1]
 */

package main

import (
	"fmt"
	"time"
)

type HanoiState struct {
	n, disk int
	x, y, z byte
}

const (
	SIZE = 50
)

func (hs *HanoiState) Set(n int, disk int, x byte, y byte, z byte) {
	hs.n, hs.disk, hs.x, hs.y, hs.z = n, disk, x, y, z
}
func hanoi(n int, x byte, y byte, z byte) {
	var count, i int
	var hs [SIZE]HanoiState
	hs[0] = HanoiState{n, n, x, y, z}
	i++
	tmp := hs[0]
	for i > 0 {
		i--
		tmp = hs[i]
		if tmp.n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, tmp.disk, tmp.x, tmp.z)
		} else {
			//push()
			hs[i].Set(tmp.n-1, tmp.n-1, tmp.y, tmp.x, tmp.z)
			i++
			hs[i].Set(1, tmp.n, tmp.x, tmp.y, tmp.z)
			i++
			hs[i].Set(tmp.n-1, tmp.n-1, tmp.x, tmp.z, tmp.y)
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
