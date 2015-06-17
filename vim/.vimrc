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
"  vundle ���
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
"  < �жϲ���ϵͳ�� Windows ���� Linux >
"------------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
	let g:iswindows = 1
else
	let g:iswindows = 0
endif
"------------------------------------------------------------------------------
"  < �жϲ���ϵͳ���ն˻���gvim>
"------------------------------------------------------------------------------
if has("gui_running")
	let g:isGUI = 1
else
	let g:isGUI = 0
endif
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
"vim ��������
let &termencoding=&encoding
set fileencodings=ucs-bom,utf-8,chinese,cp936,gbk
set encoding=utf-8
if has("win32")
	set fileencoding=chinese
else
	set fileencoding=utf-8
endif

" ����˵�����  
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
language message zh_CN.UTF-8  
"--------------------------------------------------------------------------------- 


"���ñ��ʹ�õ�����
if g:iswindows
	"windows����������
	set guifont=consolas:h10.5
	set guioptions-=m "disable menu
	set guioptions-=T "disable toolbar
endif	
if !g:iswindows
	"linux����������
	set guifont=Ubuntu\ Mono\ 10.5 
	set gfw=WenQuanYi\ Micro\ Hei\ Mono\ 10
	set guioptions-=m "disable menu
	set guioptions-=T "disable toolbar
endif	

"����gvim����
if (g:isGUI)
	colorscheme morning
endif

syntax on
"��ʾ�к�
set nu

"�﷨����"
autocmd FileType html,css setlocal shiftwidth=2 tabstop=2
autocmd FileType c,h,cpp,go,java,python,json,javascript setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
filetype plugin indent on 

"�Զ���ȫ����:
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
" Go��������
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

"����tagbar (tagbar ����ctags)
"�趨windowsϵͳ��ctags�����λ��
let g:tagbar_ctags_bin = 'D:\Program Files\Vim\vim74\ctags.exe'
"�趨linuxϵͳ��ctags�����λ��
"let g:tagbar_ctags_bin = '/usr/bin/ctags'
"�趨tagbar���ڿ��
let g:tagbar_width = 30
"ӳ��F9��/�ر�tagbar���� 
nmap <silent> <F9> :TagbarToggle<cr>    

"�ڵ�һ��ʹ��ʱ��cmd������Ŀ�ĸ�Ŀ¼�£�ִ�����ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
"��ݼ��� ������Ҫ�鿴�ĺ����ϣ���ctrl+],���붨�壬ctrl+o����֮ǰλ�ã�

"�ں������ƶ����
"	[{ ת����һ��λ�ڵ�һ�е�"{"
"	}]  ת����һ��λ�ڵ�һ�е�"{"
"	{   ת����һ������
"	}   ת����һ������
"	gd  ת����ǰ�����ָ�ľֲ������Ķ���
"	*   ת����ǰ�����ָ�ĵ�����һ�γ��ֵĵط�
"	#   ת����ǰ�����ָ�ĵ�����һ�γ��ֵĵط�

"��ctags������ĿĿ¼�ṹ����tag�ļ�
set tags=tags;/

"������ֶ��tags���Զ���ʾ�����б�
nmap <C-]> :tjump <C-R>=expand("<cword>")<CR><CR>

"vim �Զ�����ctags

function! UPDATE_TAGS()
	let _f_ = expand("%:p")
	let _cmd_ =  '"ctags -a -f /dvr/tags --c++-kinds=+p --fields=+iaS --extra=+q " '  . '"' . _f_ . '"'
	let _resp = system(_cmd_)
	unlet _cmd_
	unlet _f_
	unlet _resp
endfunction
autocmd BufWrite *.cpp,*.h,*.c call UPDATE_TAGS()

"���ý����ļ�Ŀ¼
set directory=$TMP
