�ҵ�vim����:
=========
#�Ѱ�װ�Ĳ��:
    1.markdown�﷨����
    2.vimim, vimim.cjk.txt, vimim.pinyin_quote_sogou.txt
    3.ctags
    4.taglist
    5.golang֧��
#vimrc ��������:
    "golang �﷨����
    set rtp+=$GOROOT/misc/vim 
    filetype plugin indent on 
    syntax on 
    
    "��ʾ�к�
    set nu
    
    "����taglist (taglist ����ctags)
    "�趨windowsϵͳ��ctags�����λ��
    let Tlist_Ctags_Cmd = '"D:\Program Files\Vim\vim73\ctags.exe"'
    "�趨linuxϵͳ��ctags�����λ��
    "let Tlist_Ctags_Cmd = '/usr/bin/ctags'
    let Tlist_Show_One_File = 1            "��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���
    let Tlist_Exit_OnlyWindow = 1          "���taglist���������һ�����ڣ����˳�vim
    let Tlist_Use_Right_Window = 1         "���Ҳര������ʾtaglist����
    let TList_Show_Menu = 1                "��ʾtaglist�˵�
    "ӳ��F9��/�ر�taglist���� 
    map <silent> <F9> :TlistToggle<cr>    
    
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
