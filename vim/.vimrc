"  < 判断操作系统是 Windows 还是 Linux >
"------------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif
"------------------------------------------------------------------------------
"  < 判断操作系统是终端还是gvim>
"------------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" 解决菜单乱码  
"-------------------------------------------------------------------------------  
set langmenu=zh_CN  
let $LANG = 'zh_CN.UTF-8'  
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
  
"vim 提示信息乱码解决方法  
if has("win32")  
set termencoding=chinese  
language message zh_CN.UTF-8  
endif  
"--------------------------------------------------------------------------------- 


"设置编程使用的字体
if g:iswindows
	"windows下设置vim编码
	let &termencoding=&encoding
	set fileencodings=ucs-bom,utf-8,cp936,gbk
	set encoding=utf-8
	"windows下设置字体
	set guifont=consolas:h10.5
	set guioptions-=m "disable menu
	set guioptions-=T "disable toolbar
endif	
if !g:iswindows
	"linux下设置vim编码
	let &termencoding=&encoding
	set fileencodings=ucs-bom,utf-8,cp936,gbk
	"linux下设置字体
	set guifont=Ubuntu\ Mono\ 10.5 
	set gfw=WenQuanYi\ Micro\ Hei\ Mono\ 10
	set guioptions-=m "disable menu
	set guioptions-=T "disable toolbar
endif	

"设置gvim主题
if (g:isGUI)
	colorscheme morning
endif

"Go语言配置的部分
"语法高亮
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
syntax on 

"gotags配置
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
"=================Go语言配置部分结束====================

"显示行号
set nu

"语法缩进"
autocmd FileType html,css setlocal shiftwidth=2 tabstop=2
autocmd FileType c,h,cpp,go,java,python,json,javascript setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
filetype plugin indent on 

"自动补全设置:
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"Go fmt at save
autocmd FileType go autocmd BufWritePre <buffer> Fmt
"Goimports"
let g:gofmt_command="goimports"

"设置tagbar (tagbar 依赖ctags)
"设定windows系统中ctags程序的位置
let g:tagbar_ctags_bin = 'D:\Program Files\Vim\vim74\ctags.exe'
"设定linux系统中ctags程序的位置
"let g:tagbar_ctags_bin = '/usr/bin/ctags'
"设定tagbar窗口宽度
let g:tagbar_width = 30
"映射F9打开/关闭tagbar窗口 
nmap <silent> <F9> :TagbarToggle<cr>    

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

"设置交换文件目录
set directory=$TMP
