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

"���ñ��ʹ�õ�����
if g:iswindows
	"windows������vim����
	let &termencoding=&encoding
	set fileencodings=ucs-bom,utf-8,cp936,gbk
	set encoding=utf-8
	"windows����������
	set guifont=consolas:h10.5
	set guioptions-=m "disable menu
	set guioptions-=T "disable toolbar
endif	
if !g:iswindows
	"linux������vim����
	let &termencoding=&encoding
	set fileencodings=ucs-bom,utf-8,cp936,gbk
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

"Go�������õĲ���
"�﷨����
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
syntax on 

"gotags����
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
"=================Go�������ò��ֽ���====================

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

"Go fmt at save
autocmd FileType go autocmd BufWritePre <buffer> Fmt
"Goimports"
let g:gofmt_command="goimports"

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
