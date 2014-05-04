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
			/*hs[i] = HanoiState{tmp.n - 1, tmp.n - 1, tmp.y, tmp.x, tmp.z}
			i++
			hs[i] = HanoiState{1, tmp.n, tmp.x, tmp.y, tmp.z}
			i++
			hs[i] = HanoiState{tmp.n - 1, tmp.n - 1, tmp.x, tmp.z, tmp.y}
			i++*/
			temp := &hs[i]
			temp.n, temp.disk, temp.x, temp.y, temp.z = tmp.n-1, tmp.n-1, tmp.y, tmp.x, tmp.z
			i++
			temp = &hs[i]
			temp.n, temp.disk, temp.x, temp.y, temp.z = 1, tmp.n, tmp.x, tmp.y, tmp.z
			i++
			temp = &hs[i]
			temp.n, temp.disk, temp.x, temp.y, temp.z = tmp.n-1, tmp.n-1, tmp.x, tmp.z, tmp.y
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
