package main

import "fmt"
import "time"

//import "runtime/pprof"
//import "flag"
//import "log"
//import "os"

var count int = 0

func hanoi(n int, x byte, y byte, z byte) {
	if n == 1 {
		count++
		//fmt.Printf("%d. Move disk %d from %c to %c\n", count, n, x, z)
	} else {
		hanoi(n-1, x, z, y)
		count++
		//fmt.Printf("%d. Move disk %d from %c to %c\n", count, n, x, z)
		hanoi(n-1, y, x, z)
	}
}

//var cpuprofile = flag.String("cpuprofile", "", "write cpu profile to this file")
//var memprofile = flag.String("memprofile", "", "write memory profile to this file")
//var reuseLoopGraph = flag.Bool("reuseloopgraph", true, "reuse loop graph memory")
func main() {
	/*flag.Parse()
	if *cpuprofile != "" {
		f,err := os.Create(*cpuprofile)
		if err != nil {
			log.Fatal(err)
		}
		pprof.StartCPUProfile(f)
		defer pprof.StopCPUProfile()
	}*/

	start := time.Now()
	hanoi(25, 'A', 'B', 'C')
	duration := time.Since(start)
	fmt.Println(duration)
}
