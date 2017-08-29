package main

func main() {
	a := make(map[int]int)
	for i := 0; i < 100000000; i++ {
		a[i&0xffff] = i
	}
}
