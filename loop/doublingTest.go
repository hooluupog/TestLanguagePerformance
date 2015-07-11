package main

func Count(a []int) int {
	n := len(a)
	cnt := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				if a[i]+a[j]+a[k] == 0 {
					cnt++
				}
			}
		}
	}
	return cnt
}

func timeTrial(n int) int {
	a := make([]int, n)
	for i := 0; i < n; i++ {
		a[i] = i + 1
	}
	return Count(a)
}
func main() {
	res := timeTrial(250)
	res = timeTrial(500)
	res = timeTrial(1000)
	res = timeTrial(2000)
	_ = res
}
