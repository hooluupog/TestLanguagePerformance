set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"  -------------------------------------------------------------
"  vundle 插件
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$VIM/vimfiles/bundle/vundle.vim
"call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
call vundle#begin('$VIM/vimfiles/bundle')
" let Vundle manage Vundle, required
Plugin 'SirVer/ultisnips'
Plugin 'fatih/vim-go'
Plugin 'gmarik/Vundle.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"--------------------------------------------------
"
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
"vim 编码设置
let &termencoding=&encoding
set fileencodings=ucs-bom,utf-8,chinese,cp936,gbk
set encoding=utf-8
if has("win32")
	set fileencoding=chinese
else
	set fileencoding=utf-8
endif

" 解决菜单乱码  
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
language message zh_CN.UTF-8  
"--------------------------------------------------------------------------------- 


"设置编程使用的字体
if g:iswindows
	"windows下设置字体
	set guifont=consolas:h10.5
	set guioptions-=m "disable menu
	set guioptions-=T "disable toolbar
endif	
if !g:iswindows
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

syntax on
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
"
" Go语言配置
"Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" ultisnips configuration
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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
