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
	SIZE = 100
)

func hanoi(n int, x byte, y byte, z byte) {
	var count int = 0
	hs := make([]HanoiState, 0, SIZE)
	hs = append(hs, HanoiState{n, n, x, y, z})
	tmp := hs[len(hs)-1]
	for len(hs) > 0 {
		tmp, hs = hs[len(hs)-1], hs[:len(hs)-1] //pop()
		if tmp.n == 1 {
			count++
			//fmt.Printf("%d. Move disk %d from %c to %c\n", count, tmp.disk, tmp.x, tmp.z)
		} else {
			//push()
			hs = append(hs, HanoiState{tmp.n - 1, tmp.n - 1, tmp.y, tmp.x, tmp.z})
			hs = append(hs, HanoiState{1, tmp.n, tmp.x, tmp.y, tmp.z})
			hs = append(hs, HanoiState{tmp.n - 1, tmp.n - 1, tmp.x, tmp.z, tmp.y})
		}
	}
}

func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Println(duration)
}
