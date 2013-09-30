package main

import (
	"fmt"
	"bufio"
	"os"
)

func main() {
	b := bufio.NewWriter(os.Stdout)
	for i := 0; i < 1 << 25; i++ {
		fmt.Fprint(b,i)
	}
    b.Flush()
}
