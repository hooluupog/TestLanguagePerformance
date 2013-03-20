package main

import "fmt"
import "time"

var count int = 0

func hanoi(n int, x byte, y byte, z byte) {
	if n == 1 {
		count = count + 1
		//fmt.Printf("%d. Move disk %d from %c to %c\n", count, n, x, z)
	} else {
		hanoi(n-1, x, z, y)
		count = count + 1
		//fmt.Printf("%d. Move disk %d from %c to %c\n", count, n, x, z)
		hanoi(n-1, y, x, z)
	}
}
func main() {
	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Printf(" %vms\n", duration.Seconds()*1000)
}
