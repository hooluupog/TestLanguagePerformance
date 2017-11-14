package main

import (
	"fmt"
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

func evenSum(list []int, sum chan int) {
	res := 0
	for _, v := range list {
		if v%2 == 0 {
			res += v
		}
	}
	sum <- res
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
	sum := make(chan int)
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
	for i, offset := 0, LEN/N; i < N; i++ {
		go evenSum(list[i*offset:i*offset+offset], sum)
	}
	totalSum(sum)
	duration = time.Since(start)
	fmt.Printf("parallel sum: %vms\n", duration.Seconds()*1000)
	close(sum)
}
