#TestLanguagePeformance
======================
##不同类型编程语言的简单性能测试
###所使用的语言：
    Go
    java
    c/c++
    python
    Dart
###目前已有的测试单元：
####1. 递归测试 ——汉诺塔程序
栈模拟递归——汉诺塔程序     
####2. 大数运算
####3. I/O性能测试
####其他测试单元代码待补充。。。
###测试用到的命令：
    $ strace -f -F -o output.txt  ./execute > /dev/null    #linux strace tool
    $ time  ./execute > /dev/null      #evaluate the running time of application
    $ go build -gcflags -m xxx.go    #to watch the compiler optimization for producing code   eg. inline some fuction
    $ go tool 6g/8g  -S xxx.go > xxx.s    #get  disassembly code from source code
    $ time xxx > /dev/null
