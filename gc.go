//Testing whether garbgage collector return unused memory to OS.
package main

import (
	"math/rand"
	"runtime/debug"
	//"runtime"
	"time"
)

func DoSomeThing() {
	a := make([][]interface{}, 5000)
	for i := 0; i < len(a); i++ {
		a[i] = make([]interface{}, 5000)
		for j := 0; j < len(a[i]); j++ {
			a[i][j] = rand.Float64()
		}
	}
}

func main() {
	DoSomeThing()
	for {
		println("idle")
		//runtime.GC()
		debug.FreeOSMemory()
		time.Sleep(2 * time.Second)
	}
}
