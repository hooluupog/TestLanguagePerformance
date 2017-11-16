package main

import (
	"fmt"
	"math/big"
	"time"
)

func main() {
	var a, b string
	fmt.Scan(&a, &b)
	start := time.Now()
	/** SetString(a string,base int)-----将输入的字符串处理为BigInt
	** The base argument must be 0 or a value from 2 through MaxBase.
	** If the base is 0,the string prefix determines the actual conversion base.
	** A prefix of “0x” or “0X” selects base 16;
	** the “0” prefix selects base 8, and a “0b” or “0B” prefix selects
	** base 2. Otherwise the selected base is 10.
	** 例如:输入的字符串为"1234...",表示该字符串为10进制，base=10;
	**      输入的字符串为"0x10ac1...",表示该字符串为16进制，base=16
	**      base开始取0时，当输入的字符串为"0x101...",前缀为"0x",表示该字符串为16
	**      进制，所以base的实际值为16
	**/
	c := new(big.Int)
	d := new(big.Int)
	e := new(big.Int)
	c.SetString(a, 10)
	d.SetString(b, 10)
	e.Mul(c, d)
	fmt.Println(e)
	duration := time.Since(start)
	fmt.Println(duration)
}
