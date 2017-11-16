// test the Go compiler optimization level.
// hanoi_go1.go execute time should equal hanoi_go1.go.
package main

import "fmt"
import "time"

var count int = 0

func hanoi(n int, x byte, y byte, z byte) {
	if n > 0 {
		hanoi(n-1, x, z, y)
		count++
		//fmt.Printf("%d. Move disk %d from %c to %c\n", count, n, x, z)
		hanoi(n-1, y, x, z)
	}
}
func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Println(duration)
}
