package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	var w = bufio.NewWriter(os.Stdout)
	for i := 0; i < 1<<25; i++ {
		fmt.Fprintln(w, i)
	}
	w.Flush()
}
