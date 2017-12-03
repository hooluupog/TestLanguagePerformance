// Parallel sort.

package main

import (
	"bufio"
	"fmt"
	"io"
	"math/rand"
	"os"
	"time"
)

const (
	MAXGOROUTINES          = 30
	INSERTSORT_THRESHOLD   = 10
	STOPPARALELL_THRESHOLD = 1000
)

func InsertSort(a []int) {
	for i := 1; i < len(a); i++ { // 依次将a[1]~a[len-1]插入到前面已排序序列
		temp := a[i]   // 暂存a[i]
		l, h := 0, i-1 // 设置折半查找范围
		for l <= h {   // 开始折半查找(升序)
			mid := (l + h) / 2 // 取中间点
			if a[mid] > temp { // 查找左半子表
				h = mid - 1
			} else { // 查找右半子表
				l = mid + 1
			}
		}
		for j := i - 1; j >= h+1; j-- { // 统一后移元素，空出插入位置
			a[j+1] = a[j]
		}
		a[h+1] = temp // 插入操作
	}
}

// Classic quicksort.
func Qsort(s []int) {
	if len(s) <= 1 {
		return
	}
	if len(s) <= INSERTSORT_THRESHOLD {
		InsertSort(s)
		return
	}
	pivotIdx := partition(s)
	Qsort(s[:pivotIdx])
	Qsort(s[pivotIdx+1:])
	return
}

// parallel quicksort.
func Psort(s []int) {
	if len(s) <= 1 {
		return
	}
	workers := make(chan int, MAXGOROUTINES-1)
	for i := 0; i < (MAXGOROUTINES - 1); i++ {
		workers <- 1
	}
	psort(s, nil, workers)
}

func partition(a []int) int {
	rIndex := rand.Int() % (len(a))
	a[rIndex], a[0] = a[0], a[rIndex] // 将枢值交换到第一个元素
	pivotkey := a[0]                  // 置当前表中第一个元素为枢轴值
	i := 0
	for j := 1; j < len(a); j++ { // 从第二个元素开始找小于基准的元素
		if a[j] < pivotkey { // 找到和交换到前面
			i++
			a[i], a[j] = a[j], a[i]
		}
	}
	a[i], a[0] = a[0], a[i] // 将基准元素插入到最终位置
	return i
}

func psort(s []int, done chan int, workers chan int) {
	// report to caller that we're finished
	if done != nil {
		defer func() { done <- 1 }()
	}

	if len(s) <= 1 {
		return
	}

	if len(s) <= INSERTSORT_THRESHOLD {
		InsertSort(s)
		return
	}

	if len(s) <= STOPPARALELL_THRESHOLD {
		Qsort(s)
		return
	}

	// since we may use the doneChannel synchronously
	// we need to buffer it so the synchronous code will
	// continue executing and not block waiting for a read
	doneChannel := make(chan int, 1)
	pivotIdx := partition(s)

	select {
	case <-workers:
		// if we have spare workers, use a goroutine
		// for parallelization
		go psort(s[:pivotIdx], doneChannel, workers)
	default:
		// if no spare workers, sort synchronously
		psort(s[:pivotIdx], nil, workers)
		// calling this here as opposed to using the defer
		doneChannel <- 1
	}
	// use the existing goroutine to sort above the pivot
	psort(s[pivotIdx+1:], nil, workers)
	// if we used a goroutine we'll need to wait for
	// the async signal on this channel, if not there
	// will already be a value in the channel and it shouldn't block
	<-doneChannel
	return
}

func main() {
	var a int
	var l []int
	r := bufio.NewReader(os.Stdin)
	//w := bufio.NewWriter(os.Stdout)
	for {
		_, err := fmt.Fscan(r, &a)
		if err == io.EOF {
			break
		}
		l = append(l, a)
	}
	ll := make([]int, len(l))
	copy(ll, l)
	start := time.Now()
	Qsort(l)
	elapsed := time.Since(start)
	fmt.Println("Classic QuickSort time used: ", elapsed)
	start = time.Now()
	Psort(ll)
	elapsed = time.Since(start)
	fmt.Println("Parallel QuickSort time used: ", elapsed)
	//fmt.Fprintln(w, l)
	//w.Flush()
}
