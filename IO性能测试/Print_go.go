package main

import "bytes"
import "fmt"

func main() {
	var b bytes.Buffer
	for i := 0; i < 1<<25; i++ {
		fmt.Fprintln(&b, i)
		b.Reset()
	}
}
