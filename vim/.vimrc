"golang 语法高亮
set rtp+=$GOROOT/misc/vim 
syntax on 

"显示行号
set nu

"语法缩进"
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType c,h,cpp,go,java,python,json,js setlocal expandtab shiftwidth=4 softtabstop=4
filetype plugin indent on 

"windows下设置vim编码
let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936

"设置taglist (taglist 依赖ctags)
"设定windows系统中ctags程序的位置
let Tlist_Ctags_Cmd = '"D:\Program Files\Vim\vim73\ctags.exe"'
"设定linux系统中ctags程序的位置
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口
let TList_Show_Menu = 1                "显示taglist菜单
"映射F9打开/关闭taglist窗口 
map <silent> <F9> :TlistToggle<cr>    

"在第一次使用时，cmd进入项目的根目录下，执行命令：ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
"快捷键： 鼠标放在要查看的函数上，按ctrl+],进入定义，ctrl+o返回之前位置；

"在函数中移动光标
"	[{ 转到上一个位于第一列的"{"
"	}]  转到下一个位于第一列的"{"
"	{   转到上一个空行
"	}   转到下一个空行
"	gd  转到当前光标所指的局部变量的定义
"	*   转到当前光标所指的单词下一次出现的地方
"	#   转到当前光标所指的单词上一次出现的地方

"让ctags分析项目目录结构生成tag文件
set tags=tags;/

"如果发现多个tags，自动显示出来列表
nmap <C-]> :tjump <C-R>=expand("<cword>")<CR><CR>

"vim 自动更新ctags

function! UPDATE_TAGS()
  let _f_ = expand("%:p")
  let _cmd_ =  '"ctags -a -f /dvr/tags --c++-kinds=+p --fields=+iaS --extra=+q " '  . '"' . _f_ . '"'
 let _resp = system(_cmd_)
  unlet _cmd_
  unlet _f_
  unlet _resp
endfunction
autocmd BufWrite *.cpp,*.h,*.c call UPDATE_TAGS()
