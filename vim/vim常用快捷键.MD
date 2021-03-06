## 移动光标操作：
```
按从小到大的顺序为（括号内为相应的操作命令）：  
字符（h、l）→ 单词 (w、W、b、B、e) → 行 (j、k、0、^、$、:n) → 
句子（(、)）→ 段落（{、}）→ 屏 (H、M、L) → 页
（Ctrl-f、Ctrl-b、Ctrl-u、Ctrl-d) → 文件（G、gg、:0、:$）
```
## 编辑操作：
```
按从小到大的顺序为（括号内为相应的操作命令）：
字符 （x、c、s、r、i、a）→ 单词 (cw、cW、cb、cB、dw、dW、db、dB) → 
行 (dd、d0、d$、I、A、o、O) → 句子（(、)）→ 段落（{、}）。
这些操作单位有些可以加操作次数。操作对象的范围计算公式为：
操作范围 = 操作次数 * 操作单位。
比如：d3w 命令删除三个单词，10dd 命令删除十行。
```
## 移动
功能|命令|
:----|:----:|
上下左右|h, j, k, l|  
右移10列|10l|
移动到指定字符(行内移动)|
右边第一个`x`字符|`fx`|
左边第一个`x`字符|`Fx`|
右边第一个`x`字符之前|`tx`|
左边第一个`x`字符之后|`Tx`|
右边第三个`x`字符|`3fx`|
重复前一条指令|`;`|
反方向重复前一条指令|`,`|
&nbsp;|
行首|`0`|
行尾|`$`|
行首第一个非空白字符|`^`|
下一个单词词首|`w`|
上一个单词词首|`b`|
下一个单词词尾|`e`|
上一个单词词尾|`ge`|
下一个字串(以空格分隔)首部|`W`|
上一个字串(以空格分隔)首部|`B`|
下一个字串(以空格分隔)尾部|`E`|
上一个字串(以空格分隔)尾部|`gE`|
## 跳转
功能|命令|
:----|:----:|
翻页|`Ctrl`+`b` `Ctrl`+`f`|
跳转到文件第一行|`gg`|
跳转到文件最后一行|`G`|
跳转到第10行|`10G`|
跳转到75%处|`75%`|
跳转到当前窗口的顶、中、底部|`H/M/L`|
光标滚屏|
光标所在的行移动到窗口的顶、中、底部|`zt/zz/zb`|
&nbsp;|
返回到最后跳转到的位置|` `` ` `''`|
返回到更早的跳转位置|`Ctrl`+`o`|
返回到更近的跳转位置|`Ctrl`+`i`|
定位光标当前的位置|`Ctrl`+`g`|
匹配(例如光标在`{`，移动到与之匹配的`}`)|`%`|
句子间跳转|`(` `)`|
段落间跳转|`{` `}`|
标记命令`m`，位置标记小写：当前文件缓冲区间有效；大写：文件间有效|
标记跳转位置|`ma`, 键入`a`跳转至a处|
标记跳转位置|`mA`, 键入`A`跳转至A处|
&nbsp;|
函数间跳转（需要ctags的支持）|
跳转到函数定义处|`Ctrl`+`]`|
跳转到函数返回处|`Ctrl`+`T`|
## 切换
功能|命令|
:----|:----:|
新建窗口|（crtl + w） n
分割窗口| (ctrl + w) s `:split`|
垂直分割窗口|`Ctrl` + `w` `v` / `:vsplit`|
关闭当前窗口|`Ctrl` + `w` `c` / `zz` / `:q`|
关闭其它窗口|`Ctrl` + `w` `o`|
向上轮换窗口|`Ctrl` + `w` `R`|
向下轮换窗口|`Crtl` + `w` `r`|
使窗口等宽|`Crtl` + `w` `=`|
使窗口向上最小化|`Ctrl` + `w` `1_`|
使窗口向下最大化|`Crtl` + `w` `_`|
使窗口向左最小化|`Crtl` + `w` 1&#124;|
使窗口向右最大化|`Crtl` + `w` &#124;|
将缓冲区分割到一个窗口中|`Crtl` + `w` `^`|
两个窗内容切换|`Crtl` + `w` `x`|
光标窗口间移动|`Ctrl`+`w` `h/j/k/l`|
光标窗口间游走|`Ctrl`+`w`+`w`|
窗口移动|`Ctrl`+`w` `H/J/K/L`|
## 查找
功能|命令|
:----|:----:|
查找关键字|`/(输入要查找的关键字)`+`Enter`|
重复上一次查找|`n`|
反方向重复上一次查找|`N`|
查找并替换所有|`%s/(from)/(to)/g`|
查找历史记录|`q/` `q?`|
## 编辑
功能|命令|
:----|:----:|
插入|
插入到光标前|`i`|
插入到行的开始位置|`I`|
插入到光标后|`a`|
插入到行的最后位置|`A`|
新开始一行|`o` `O`(新行在当前行之上)|
删除 motion 命令跨过的字符，并且进入插入模式|`c{motion}`|
删除从光标位置到行尾的字符并且进入插入模式|`c$`|
删除从光标位置到下一个叹号（但不包括）|`ct!`|
剪切当前行并且进入插入模式|`cc`|
等同于c$|`C`|
替换|`r`|
合并下一行到上一行|`J`|
删除一行并进入插入模式|`cc`|
删除一个单词并进入插入模式|`cw`|
删除一行|`dd`|
删除一个单词|`dw`|
删除一个字串并进入插入模式|`cW`|
删除一个字串|`dW`|
删除一个字符|`x`|
删除前一个字符|`X`|
删除一行最后一个字符|`D`|
删除光标所在字符并处于插入模式下|`s`|
删除光标所在行并处于插入模式下|`S`|
&nbsp;|
复制一行|`yy`|
复制一个单词|`yw`|
粘贴|`p`|
复制到寄存器|`"+y`|
从寄存器粘贴|`"+p`|
撤销/恢复|`u`/`Ctrl`+`r`|
重复最后一个命令|`.`|
大小写转换|`~`|
右移/左移一个tab|`>>`/`<<`|
补全|`Ctrl`+`x` `Ctrl`+`o`|
补全列表|`Ctrl`+`p`(向上)  `Ctrl`+`n`(向下)|
保存|`:w`|
强制保存|`:w!`|
保存并关闭|`:wq`  `:x`|
关闭|`:q`|
强制关闭|`:q!`|
列模式 `Ctrl`+`v'|
选中一个或多个字符|`v`|
选中一行|`V`|
插入|`I` `A`|
删除{motion}命令跨过的字符并进入插入模式|`c{motion}`|
执行外部shell命令|`:!` + `(要运行的命令)`|
宏录制|`qa`(记录到寄存器a)-操作-`q`(结束记录)-`@a`(应用操作)|
文件目录操作 具体可查看newtrw命令|
`%`是一个只读寄存器，保存着当前文件路径|
打开当前目录或者指定目录|`Ex`|
水平分割窗口并打开当前目录或指定目录|`Se`|
垂直分割窗口并打开当前目录或指定目录|`Ve`|
新建标签并打开当前目录或指定目录|`Te`|
返回上一层目录|`-`|
进入目录或读取文件|`<CR>(回车键)`|
新建文件|`:new` 文件名.后缀|
打开文件|`:e` 文件名|
删除文件或目录|`D`|
建立目录|`d`|
使浏览中的目录成为当前目录|`c`|
重命名文件或目录|`R`|
刷新当前目录列表|`Crtl` + `l`|
&nbsp;|


