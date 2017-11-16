package main

import (
	"fmt"
	"sync"
	"time"
)

const (
	N   = 100
	LEN = 30000000
)

type intSlice []int

func (is intSlice) Filter(f func(int) bool) intSlice {
	vs := make(intSlice, 0)
	for _, v := range is {
		if f(v) {
			vs = append(vs, v)
		}
	}
	return vs
}

func (is intSlice) Map(f func(int) int) intSlice {
	vs := make(intSlice, len(is))
	for i, v := range is {
		vs[i] = f(v)
	}
	return vs
}

func (is intSlice) Reduce(f func(int, int) int) int {
	var res int
	for _, v := range is {
		res = f(v, res)
	}
	return res
}

func loopSum(list []int) {
	res := 0
	for _, v := range list {
		if v%2 == 0 {
			res += v
		}
	}
	fmt.Println(res)
}

func Sum(list []int) {
	is := intSlice(list)
	res := is.Filter(func(i int) bool { return i%2 == 0 }).
		Reduce(func(a, b int) int { return a + b })
	fmt.Println(res)
}

func evenSum(wg *sync.WaitGroup, in <-chan []int, out chan<- int) {
	defer wg.Done()
	list := <-in
	res := 0
	for _, v := range list {
		if v%2 == 0 {
			res += v
		}
	}
	out <- res
}

func totalSum(sum <-chan int) {
	total := 0
	for i := 0; i < N; i++ {
		total += <-sum
	}
	fmt.Println(total)
}

func main() {
	list := make([]int, LEN)
	in := make(chan []int, N)
	sum := make(chan int, N)
	defer close(sum)
	var wg sync.WaitGroup
	for i := range list {
		list[i] = i
	}

	start := time.Now()
	loopSum(list)
	duration := time.Since(start)
	fmt.Printf("loopSum: %vms\n", duration.Seconds()*1000)

	start = time.Now()
	Sum(list)
	duration = time.Since(start)
	fmt.Printf("Sum using reduce: %vms\n", duration.Seconds()*1000)

	start = time.Now()
	// Go's approach to concurrency differs from the traditional use of threads and shared memory.
	// Philosophically, it can be summarized:
	// Don't communicate by sharing memory; share memory by communicating.
	// Channels allow you to pass references to data structures between goroutines. If you consider this
	// as passing around [ownership of the data] (the ability to read and write it), they become a powerful
	// and expressive synchronization mechanism.
	// In this program, the convention is that sending a slice (pointer) on a channel passes ownership of
	// the underlying data from the sender to the receiver. Because of this convention, we know that no
	// two goroutines will access this slice at the same time. This means we don't have to worry about locking
	// to prevent concurrent access to these data structures.

	for i, offset := 0, LEN/N; i < N; i++ {
		in <- list[i*offset : i*offset+offset]
		wg.Add(1)
		go evenSum(&wg, in, sum)
	}
	wg.Wait()
	close(in)
	totalSum(sum)
	duration = time.Since(start)
	fmt.Printf("parallel sum: %vms\n", duration.Seconds()*1000)
}
