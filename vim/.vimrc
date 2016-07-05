" ============================================================================
"				<< 基判断操作系统是否是 Windows 还是 Linux >>								
" ============================================================================
let g:iswindows = 0
let g:islinux 	= 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux 	= 1
endif


" VIM ORIGIN DEFAULT CONFIG---------------------------------------------------------------------------START
set nocompatible "关闭兼容模式

" windows下才有效：模仿windows快捷键 Ctrl+A全选、Ctrl+C复制、Ctrl+V粘贴
if (g:iswindows)
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

	" 默认的自己的参数代码段
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
endif
" VIM ORIGIN DEFAULT CONFIG---------------------------------------------------------------------------END


" VIM CONFIG SET BY huayue_hu*************************************************************************START 
"
" ============================================================================
"							<< 基本设定 >>								
" ============================================================================
"
" ---vimrc文件设定
" 不使用本地版本（.g(vimrc), .exrc） 
" set noexrc 
" set cpoptions=aABceFsmq 

" ---界面设置
" colorscheme molokai         " 设定配色方案
colorscheme Tomorrow-Night-Eighties         " 设定配色方案
let g:solarized_en = 0
if (g:solarized_en)
	syntax enable
	set background=dark
	" set background=light
	" let g:solarized_termcolors=256
	colorscheme solarized		" 设定配色方案
	" option name default optional ------------------------------------------------
	let g:solarized_termcolors= 16 | 256 
	let g:solarized_termtrans = 0 | 1 
	let g:solarized_degrade = 0 | 1 
	let g:solarized_bold = 1 | 0 
	let g:solarized_underline = 1 | 0 
	let g:solarized_italic = 1 | 0 
	let g:solarized_contrast = "normal"| "high" or "low" 
	let g:solarized_visibility= "normal"| "high" or "low"
endif

au GUIEnter * simalt ~x		" 启动窗口最大化
syntax on                   " 自动语法高亮
set number                  " 显示行号
set cursorline              " 高亮显示当前行
set cursorcolumn			" 高亮显示当前列
set guioptions-=T           " 隐藏工具栏
set guioptions-=m           " 隐藏菜单栏
set guioptions-=r 			" 关闭右侧滚动条
set guioptions-=L 			" 关闭左侧滚动条
" 在状态行上显示光标所在位置的行号和列号(使用powerline插件后无效,但仍可保留)
set ruler                   " 打开状态栏标尺(默认已打开)
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%) 
" 设置字体、字号
set anti enc=utf-8
set guifont=Courier_New:h13:cANSI

" ---缩进设置
set tabstop=4               " 设定 tab 长度为 4
set shiftwidth=4			" (shift)+(</>)时对齐长度为 4
set smartindent				" 为C程序提供自动缩进
set cindent					" 使用C样式的缩进

" ---搜索设置
set ignorecase				" 搜索忽略大小写
set incsearch               " 输入搜索内容时就显示搜索结果
set hlsearch                " 搜索时高亮显示被找到的文本
set magic                   " 设置魔术(正则表达式:除了 $ . * ^ 之外其他元字符都要加反斜杠)
" set nowrapscan              " 禁止在搜索到文件两端时重新搜索

" ---文件操作
set nobackup				"不生成备份文件
set autowrite				"自动写入缓冲区

" ---Set to auto read when a file is changed from the outside
if exists("&autoread")
set autoread
endif

" ---linux下透明背景设置
if (g:islinux)
	hi Normal  ctermfg=252 ctermbg=none 
endif

" ---其它操作
"filetype on
"filetype plugin on
"filetype indent on
"set noerrorbells            " 关闭错误信息响铃
"set backspace=indent,eol,start				" 使回格键（backspace）正常处理indent, eol, start等
"set whichwrap+=<,>,h,l		" 允许backspace和光标键跨越行边界
"set nowrap 				" 禁止折叠行


" ============================================================================
"							<< 编码设定 >>								
" ============================================================================
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif


" ============================================================================
"							<< 插件配置 >>								
" ============================================================================
"
" -------------------------------------------------------------
"  < vundle 插件配置 >
" -------------------------------------------------------------
filetype off	"禁用文件类型侦测

if (g:islinux)
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" ---Let Vundle manage Vundle
" ~~~用于管理(安装与卸载)从 "https://github.com" 上下载的插件
Bundle 'gmarik/vundle'

" ---Define bundles via Github repos
" ~~~ctrlp用于文件搜索，ctrlpfunky用于搜索当前C/C++文件里的函数
let g:ctrlp_en = 1
if (g:ctrlp_en)
	Bundle 'kien/ctrlp.vim'
	Bundle 'tacahiroy/ctrlp-funky'
endif
" ~~~文件搜索(比ctrlp搜索更全)，genutils为lookupfile辅助插件，必须同时存在
let g:lookupfile_en = 1
if (g:lookupfile_en)
	Bundle 'vim-scripts/lookupfile'
	Bundle 'vim-scripts/genutils'
endif
" ~~~显示当前文件夹目录结构
let g:nerdtree_en = 1
if (g:nerdtree_en)
	Bundle 'scrooloose/nerdtree'
endif
" ~~~显示当前文件 所在路径/编码格式/光标所在文件百分比/行列号
let g:powerline_en = 1
if (g:powerline_en)
	Bundle 'Lokaltog/vim-powerline'
endif
" ~~~光标停留时显示函数原型提示
let g:echofunc_en = 0
if (g:echofunc_en)
	Bundle 'mbbill/echofunc'
	Bundle 'vim-scripts/echofunc.vim'
endif
" ~~~注释与反注释所选内容(两个插件可以二选一)
let g:tcomment_en = 1
if (g:tcomment_en)
	Bundle 'vim-scripts/tComment'
	Bundle 'scrooloose/nerdcommenter'
endif
" ~~~显示当前文件 宏定义/变量/函数 列表
let g:taglist_en = 1
if (g:taglist_en)
	Bundle 'vim-scripts/taglist.vim'
endif
" ~~~补全关键字
let g:neocomplcache_en = 1
if (g:neocomplcache_en)
	Bundle 'Shougo/neocomplcache.vim'
	" Bundle 'vim-scripts/OmniCppComplete'
endif
" ~~~C语言语法高亮
let g:std_c_en = 1
if (g:std_c_en)
	Bundle 'vim-scripts/std_c.zip'
endif
" ~~~重复上次操作
let g:repeat_en = 1
if (g:repeat_en)
	Bundle 'tpope/vim-repeat'
endif
" ~~~显示之前打开过的窗口的缓存列表
let g:bufexplorer_en = 1
if (g:bufexplorer_en)
	Bundle 'jlanzarotta/bufexplorer'
endif
" ~~~增加多窗口标签功能
let g:minibufexpl_en = 1
if (g:minibufexpl_en)
	Bundle 'fholgado/minibufexpl.vim'
endif
" ~~~将相同缩进的代码以可视化方式显示
let g:indent_guides_en = 1
if (g:indent_guides_en)
	Bundle 'nathanaelkane/vim-indent-guides'
endif
" ~~~书签提示
let g:signature = 0
if (g:signature)
	Bundle 'kshenoy/vim-signature'
	" Bundle 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
endif
" ~~~文本查找与替换
let g:easygrep = 1
if (g:easygrep)
	Bundle 'dkprice/vim-easygrep'
endif


" ~~~管理当前vim session(会话)
" Bundle 'xolox/vim-misc'
" Bundle 'xolox/vim-session'
" Bundle 'tpope/vim-obsession'
" Bundle 'monokrome/vim-lazy-obsession'
" let g:session_autoload = 'yes'
" let g:session_autosave= 'yes'

" Bundle 'Valloric/YouCompleteMe'
" Bundle 'croaky/vim-colors-github
" Bundle 'danro/rename.vim'
" Bundle 'majutsushi/tagbar'
" Bundle 'kchmck/vim-coffee-script'
" Bundle 'pbrisbin/vim-mkdir'
" Bundle 'scrooloose/syntastic'
" Bundle 'slim-template/vim-slim'
" Bundle 'thoughtbot/vim-rspec'
" Bundle 'tpope/vim-bundler'
" Bundle 'tpope/vim-endwise'
" Bundle 'tpope/vim-fugitive'
" Bundle 'tpope/vim-rails'
" Bundle 'tpope/vim-surround'
" Bundle 'vim-ruby/vim-ruby'
" Bundle 'vim-scripts/ctags.vim'
" Bundle 'vim-scripts/matchit.zip'
" Bundle 'mattn/emmet-vim'
" Bundle 'godlygeek/tabular'
" Bundle 'msanders/snipmate.vim'
" Bundle 'jelera/vim-javascript-syntax'
" Bundle 'othree/html5.vim'
" Bundle 'xsbeats/vim-blade'
" Bundle 'Raimondi/delimitMate'
" Bundle 'groenewege/vim-less'
" Bundle 'evanmiller/nginx-vim-syntax'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'tomasr/molokai'
" Bundle 'klen/python-mode'

filetype on

" -------------------------------------------------------------
"  < ctrlp-funky 插件配置 >
" -------------------------------------------------------------
"---作用：搜索当前窗口文件匹配的关键字，并全部将相关匹配选项显示到ctrlp窗口
if (g:ctrlp_en)
	nnoremap <Leader>fu :CtrlPFunky<Cr>
	" narrow the list down with a word under cursor
	nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
	" highlight feature
	let g:ctrlp_funky_matchtype = 'path'
	" 高亮显示高级语言关键字
	let g:ctrlp_funky_syntax_highlight = 1
endif

" -------------------------------------------------------------
"  < vim-powerline 插件配置 >
" -------------------------------------------------------------
"---作用：在命令窗口上显示当前文件“编码方式”、“文件类型”、“当前光标所在文件位置”、“行列号“
"---副作用：令ctrlp,ctrlp-funky插件颜色更好看
if (g:powerline_en)
	" open a powerline quickly when vim starts up
	let g:Powerline_symbols = 'fancy'

	" Always show the statusline
	set laststatus=2   

	" 解决windows & linux下部分特殊符号显示出错的问题，需要安装4个特殊字体到系统
	" 下载源地址：https://github.com/eugeii/consolas-powerline-vim
	" 安装方法：打开"LINUX_TOOL/vim/.vim/fonts/consolas-powerline-vim-master"，双击.ttf结尾的字体文件即可(windows 和 linux下安装方法相同)
	" set guifont=Courier_New:h13:cANSI " 字体字号设置：h13代表字号
	set guifont=Consolas\ for\ Powerline\ FixedD:h13 " 字体字号设置：h13代表字号
endif

" -------------------------------------------------------------
"  < nerdtree 插件配置 >
" -------------------------------------------------------------
if (g:nerdtree_en)
	" open a NERDTree automatically when vim starts up
	" autocmd vimenter * NERDTree
	" open a NERDTree automatically when vim starts up if no files were specified
	"autocmd StdinReadPre * let s:std_in=1
	"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	" close vim if the only window left open is a NERDTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	map <F2> :NERDTreeToggle<CR>
endif
" 常用快捷键(要将光标跳到NERDTree窗口)
	" I : 显示隐藏文件
	" o : 打开目录折叠或者打开文件并跳到该文件窗口
	" O : 递归 打开选中结点下的所有目录
	" x : 合拢选中结点的父目录
	" X : 递归 合拢选中结点下的所有目录
	" r : 递归刷新选中目录
	" R : 递归刷新根结点

" -------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -------------------------------------------------------------
if (g:tcomment_en)
	" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
	" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
	" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
	" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
	" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
	" <Leader>cA 行尾注释
	let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格
endif

" -------------------------------------------------------------
"  < lookupfile 插件配置 >
" -------------------------------------------------------------
" 功能说明：高亮显示C语言语法
" 使用说明：vim 启动时自动生效
" 帮助文件：有，命令(:h lookupfile)
" 自带快捷键：没有
" 自定义快捷键："ctrl + f"
if (lookupfile_en)
	let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
	let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
	let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
	let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
	let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
	if filereadable("filenametags")                "设置tag文件的名字
		let g:LookupFile_TagExpr = '"./filenametags"'
	endif
	nmap <c-f> :LookupFile<CR>
endif

" -------------------------------------------------------------
"  < std_c 插件配置 >
" -------------------------------------------------------------
" 功能说明：高亮显示C语言语法
" 使用说明：vim 启动时自动生效
" 帮助文件：有，命令(:h std_c)
" 自带快捷键：没有
" 自定义快捷键：没有
if (g:std_c_en)
	" 停止 // 深色注视风格
	let c_cpp_comments = 1
endif

" -------------------------------------------------------------
"  < neocomplcache 插件配置 >
" -------------------------------------------------------------
" 功能说明：补全 关键字/函数名/变量/结构体成员
" 			(其实vim自身已携带此功能，当没有该插件时需要手动 "ctrl + n" 激活补全功能
" 使用说明：vim 启动时自动生效，建议通过 "ctrl + j" "ctrl + k" 上下选择，按下"Enter"后确定
" 插件缺陷：在弹出补全列表后用 <c-p> 或 <c-n> 进行上下选择后按下 "Enter" 键会导致换行
" 帮助文件：有，命令(:h neocomplcache)
" 自带快捷键：	"ctrl + n"	选择下一个
" 				"ctrl + p"	选择上一个
" 自定义快捷键：没有
if (g:neocomplcache_en)
	" 关键字补全、文件路径补全、tag补全等等，各种，非常好用，速度超快。
	let g:neocomplcache_enable_at_startup = 1     "vim 启动时启用插件
	" let g:neocomplcache_disable_auto_complete = 1 "不自动弹出补全列表
endif

" -------------------------------------------------------------
"  < omnicppcomplete 插件配置 >
" -------------------------------------------------------------
" 用于C/C++代码补全，这种补全主要针对命名空间、类、结构、共同体等进行补全，详细
" 说明可以参考帮助或网络教程等
" 使用前先执行如下 ctags 命令（本配置中可以直接使用 ccvext 插件来执行以下命令）
" ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
" 我使用上面的参数生成标签后，对函数使用跳转时会出现多个选择
" 所以我就将--c++-kinds=+p参数给去掉了，如果大侠有什么其它解决方法希望不要保留呀
" set completeopt=menu                        "关闭预览窗口

" -------------------------------------------------------------
"  < TagList 插件配置 >
" -------------------------------------------------------------
" 功能说明：列出了当前文件中的所有 宏/全局变量/函数名 列表，就像vc中的workpace
" 使用说明：常规模式下键入 tl 调用插件，并于最右生成列表窗口
" 插件引起问题：新建 quickfix 窗口时会挤到 taglist 窗口下方，影响 quickfix 阅览
" 帮助文件：有，命令(:h taglist)
" 自带快捷键：没有
" 自定义快捷键："tl"
if (g:taglist_en)
	" 如果有打开 Tagbar 窗口则先将其关闭
	" nmap tl :TagbarClose<CR>:Tlist<CR>
	nmap tl :Tlist<CR>
	let Tlist_Show_One_File=1                   "只显示当前文件的tags
	" let Tlist_Enable_Fold_Column=0              "使taglist插件不显示左边的折叠行
	let Tlist_Exit_OnlyWindow=1                 "如果Taglist窗口是最后一个窗口则退出Vim
	let Tlist_File_Fold_Auto_Close=1            "自动折叠
	let Tlist_WinWidth=30                       "设置窗口宽度
	let Tlist_Use_Right_Window=1                "在右侧窗口中显示
endif

" -------------------------------------------------------------
"  < echofunc 插件配置 >
" -------------------------------------------------------------
if (g:echofunc_en)
	set tags=./tags
endif

" -------------------------------------------------------------
"  < indent-guides 插件配置 >
" -------------------------------------------------------------
if (g:indent_guides_en)
	" 随 vim 自启动
	let g:indent_guides_enable_on_vim_startup=0
	" 从第二层开始可视化显示缩进
	let g:indent_guides_start_level=2
	" 色块宽度
	let g:indent_guides_guide_size=1
	" 快捷键 i 开/关缩进可视化
	nmap <silent> <Leader>i <Plug>IndentGuidesToggle

	let g:indent_guides_auto_colors = 0
	autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
	autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
endif

" -------------------------------------------------------------
"  < easygrep 插件配置 >
" -------------------------------------------------------------
if (g:easygrep)
	nmap <silent>;vt <Leader>vv :botright copen 6<CR>
	nmap <silent>;vs <Leader>vV :botright copen 6<CR>
endif	

" ============================================================================
"							<< 工具配置 >>								
" ============================================================================
"
" -------------------------------------------------------------
"  < cscope 工具配置 >
" -------------------------------------------------------------
" 功能说明：C/C++下 变量/函数/宏定义/头文件 跳转或搜索，搜索时在quickfix下显示搜索结果
" 使用说明：请将tools目录(或者包含cscope.exe、ctags.exe、sync.bat、sync.sh的文件夹)加到系统环境变量里
"			在工程根目录打开vim，常规模式下键入sy将在此目录产生cscope.out和tags文件，使能该工具功能
" 自带快捷键：没有
" 自定义快捷键："\fs"或者"fs"		Find this C symbol
"				"\fg"或者"fg"		Find this definition
"				"\fc"或者"fc"		Find functions calling this function
"				"\ft"或者"ft"		Find this text string	
"				"\fe"或者"fe"		Find this egrep pattern
"				"\ff"或者"ff"		Find this file
"				"\fi"或者"fi"		Find files #including this file
"				"\fd"或者"fd"		Find functions called by this function	
function! Session_load()
	" if &filetype == 'svim'
	" if has("workspace.svim")
		source 		workspace.svim
	" endif
	" if &filetype == 'viminfo'
	" if has("workspace.viminfo")
		rviminfo 	workspace.viminfo
	" endif
endfunction

function! Session_save()
	" if &filetype == 'svim'
		!rm 		workspace.svim
	" endif
	mksession! 	workspace.svim
	" if &filetype == 'viminfo'
		!rm 		workspace.viminfo
	" endif
	wviminfo! 	workspace.viminfo
endfunction

function!  CscopeSync()
	if(g:islinux)
		!bash sync.sh
	else
		!sync.bat
	endif
	" ---cscope设置
	if has("cscope")
		" 先断开先前的cscope链接
		cs kill -1
		" 设定可以使用 quickfix 窗口来查看 cscope 结果
		set cscopequickfix=s-,c-,d-,i-,t-,e-
		" 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
		set cscopetag
		" 如果你想反向搜索顺序设置为1
		set csto=0
		" 在当前目录中添加任何数据库
		if filereadable("cscope.out") 
			cs add cscope.out
			normal :<CR>
		" 否则添加数据库环境中所指出的 
		elseif $CSCOPE_DB != "" 
			cs add $CSCOPE_DB 
		endif 
		set cscopeverbose 
		" 自定义快捷键设置：针对光标在文件窗口
		nmap <Leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>:botright copen<CR>
		nmap <Leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>:botright copen<CR>	
		nmap <Leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>:botright copen<CR>
		nmap <Leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>:botright copen<CR>	
		nmap <Leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>:botright copen<CR>	
		nmap <Leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
		nmap <Leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:botright copen<CR>
		nmap <Leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>:botright copen<CR>	
		" 自定义快捷键设置：针对光标在命令输入窗口
		nmap ;fs :cscope find s 
		nmap ;fg :cscope find g 
		nmap ;fc :cscope find c 
		nmap ;ft :cscope find t 
		nmap ;fe :cscope find e 
		nmap ;ff :cscope find f 
		nmap ;fi :cscope find i 
		nmap ;fd :cscope find d 
	endif
	" ---lookupfile设置
	if filereadable("filenametags")
		let g:LookupFile_TagExpr = '"./filenametags"'
	endif
endfunction
" autocmd BufWritePost *.c,*.h silent call CscopeSync()
autocmd VimEnter *.c,*.h silent call CscopeSync()
" autocmd VimEnter * call Session_load()
" autocmd VimLeave * call Session_save()
"---常规模式下键入 sy 使能该工具 
if(g:islinux) 
	nmap sy :call CscopeSync()<CR><CR><CR>
else
	nmap sy :call CscopeSync()<CR><CR><CR>
endif

" if has("cscope")
" 	"设定可以使用 quickfix 窗口来查看 cscope 结果
" 	set cscopequickfix=s-,c-,d-,i-,t-,e-
" 	"使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
" 	set cscopetag
" 	"如果你想反向搜索顺序设置为1
" 	set csto=0
" 	"在当前目录中添加任何数据库
" 	if filereadable("cscope.out") 
" 		cs add cscope.out 
" 		"否则添加数据库环境中所指出的 
" 	elseif $CSCOPE_DB != "" 
" 		cs add $CSCOPE_DB 
" 	endif 
" 	set cscopeverbose 
" 	"---常规模式下键入 sy 使能该工具 
" 	if(g:islinux) 
" 		nmap sy :!bash sync.sh<CR><CR>
" 	else
" 		nmap sy :!sync.bat<CR><CR>
" 	endif
" 	"---自定义快捷键设置：针对光标在文件窗口
" 	nmap <Leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>:cw<CR>
" 	nmap <Leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>:cw<CR>	
" 	nmap <Leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>:cw<CR>
" 	nmap <Leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>:cw<CR>	
" 	nmap <Leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>:cw<CR>	
" 	nmap <Leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
" 	nmap <Leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:cw<CR>
" 	nmap <Leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>:cw<CR>	
" 	"---自定义快捷键设置：针对光标在命令输入窗口
" 	nmap fs :cscope find s 
" 	nmap fg :cscope find g 
" 	nmap fc :cscope find c 
" 	nmap ft :cscope find t 
" 	nmap fe :cscope find e 
" 	nmap ff :cscope find f 
" 	nmap fi :cscope find i 
" 	nmap fd :cscope find d 
" endif

" -------------------------------------------------------------
"  < vimtweak 工具配置 > 
" -------------------------------------------------------------
" 功能说明：用于窗口透明与置顶，仅限于Windows使用
" 使用说明：请确保vim74文件夹存在vimtweak.dll，并将vim74文件夹加入系统环境变量
" 自带快捷键：没有
" 自定义快捷键："shift + Up(上方向键)" 		增加不透明度
"				"shift + Down(下方向键)" 	减少不透明度
"				"<Leader>t" 				窗口置顶与否切换
if (g:iswindows)
    let g:Current_Alpha = 220
    let g:Top_Most = 0
	
    func! Alpha_add()
        let g:Current_Alpha = g:Current_Alpha + 10
        if g:Current_Alpha > 255
            let g:Current_Alpha = 255
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Alpha_sub()
        let g:Current_Alpha = g:Current_Alpha - 10
        if g:Current_Alpha < 155
            let g:Current_Alpha = 155
        endif
        call libcallnr("vimtweak.dll","SetAlpha",g:Current_Alpha)
    endfunc
    func! Top_window()
        if  g:Top_Most == 0
            call libcallnr("vimtweak.dll","EnableTopMost",1)
            let g:Top_Most = 1
        else
            call libcallnr("vimtweak.dll","EnableTopMost",0)
            let g:Top_Most = 0
        endif
    endfunc

	" 开机自动透明
	autocmd GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", g:Current_Alpha)
    " 快捷键设置
    map <s-up> :call Alpha_add()<CR>
    map <s-down> :call Alpha_sub()<CR>
    map <leader>t :call Top_window()<CR>
endif

" -------------------------------------------------------------
"  < gvimfullscreen 工具配置 >
" -------------------------------------------------------------
" 功能说明：全屏窗口(不仅是最大化)，仅限于Windows使用
" 使用说明：请确保vim74文件夹存在gvimfullscreen.dll，并将vim74文件夹加入系统环境变量
" 自带快捷键：没有 
" 自定义快捷键："F11"
if (g:iswindows)
  map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
endif


" ============================================================================
"							<< 自定义快捷键设置 >>								
" 详细map参考 "http://www.jianshu.com/p/8ae25a680ed7"
" ============================================================================
"
" ---常规模式下 空格键(space)快速进入命令输入(:)
nmap <SPACE> :
" ---常规模式下 连续输入 88 取消搜索高亮
nmap 88 :nohlsearch<CR>
" ---常规模式下 输入 / 后全字匹配搜索
nmap a/ 	/\<\><Left><Left>
" ---常规模式下 重新映射系统默认窗口切换快捷键
nmap <c-k> <c-w>k
nmap <c-j> <c-w>j
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

" ---插入模式下 光标上下左右移动
" 副作用：可以令 neocomplcache/lookupfile/ctrlpfunky/ctrlp 插件直接"ctrl + j"和"ctrl + k"上下选择，
"         并解决 neocomplcache "Enter" 键选择补全信息时会多换一行的问题
imap <c-k> <Up>
imap <c-j> <Down>
imap <c-h> <Left>
imap <c-l> <Right>

" ---常规模式下 窗口大小调整
" 使用说明："shift + ="变为"+" Y轴扩大窗口
"			"shift + -"变为"_" Y轴缩小窗口
"			"shift + ."变为">" X轴扩大窗口
"			"shift + ,"变为"<" X轴缩小窗口
nmap + <c-w>+
nmap _ <c-w>-
nmap > <c-w>>
nmap < <c-w><

" ---常规模式下 输入 cS 清除行尾空格，输入 cM 清除行尾 ^M 符号
nmap cS :%s/\s\+$//g<cr>:noh<cr>
nmap cM :%s/\r$//g<cr>:noh<cr>

" ---常规模式下 makefile 快捷键
let g:mf_way=1
" for codeblocks build
function! Codeblocks_build()
	set makeprg=codeblocks\ --build\ *.cbp 	
	make							
	botright copen 6
	" normal G
endfunction
" for makefile build
function! Makefile_build()
	set makeprg=make
	make clean
	make -j
	botright copen 6
	" normal G
endfunction
if (g:mf_way)
	" nmap <F7> :wa<CR> :make -j<CR><CR><CR> :botright copen 6<CR> <Esc>G<CR>
	" for makefile build
	" nmap <F7> :wa<CR> :set makeprg=make<CR> 						:make clean<CR><CR> :make -j<CR><CR><CR> 	:botright copen 6<CR> <Esc>G<CR>
	nmap <F7> :call Makefile_build()<CR> <Esc>/error<CR><CR>
	" for codeblocks build
	" nmap <F8> :wa<CR> :set makeprg=codeblocks\ --build\ *.cbp<CR> 	:make<CR><CR><CR>							:botright copen 6<CR> <Esc>G<CR>
	nmap <F8> :call Codeblocks_build()<CR> <Esc>/error<CR><CR>
else
	nmap <F7> :wa<CR> :make -j -f MakeALL.mk apps<CR><CR><CR> :botright copen 6<CR> <Esc>G<CR>
	nmap <F8> :wa<CR> :make -f MakeALL.mk clean<CR><CR> :make -j -f MakeALL.mk apps<CR><CR><CR> :botright copen 6<CR> <Esc>G<CR>
	" nmap <F9> :wa<CR> :make -j -f MakeALL.mk 
	nmap <F9> :wa<CR> :make -j -f MakeALL.mk<CR><CR> :botright copen 6<CR> <Esc>G<CR>
endif

" ---插入模式下 快捷键
" uart打印快捷键
imap pu<Enter> puts("\n");<Esc>F\i
imap pc<Enter> putchar('');<Esc>F'i
imap pfx<Enter> printf("=0x%x\n", );<Esc>F=i
imap pfd<Enter> printf("=%d\n", );<Esc>F=i
imap pff<Enter> printf("\n--func=%s\n", __FUNCTION__);<Esc>
" bit操作快捷键
imap ba<Enter>  &= ~BIT();<Esc>F)i
imap bo<Enter>  \|= BIT();<Esc>F)i
" 大括号自动补齐 输入"{"后按回车键自动补齐"}"并进入插入模式
imap {<Enter> {<Esc>o<tab><Esc>o}<Esc>ka
" 小括号自动补齐 输入"("后按回车键自动补齐")"并进入插入模式
imap (<Enter> ()<Esc>i

" ---常规模式下 quickfix 跳转快捷键
" 使用说明："9" 上一个要寻找的目标
"			"0" 下一个要寻找的目标
nmap 9 :cp<CR>
nmap 0 :cn<CR>

" ---常规模式下 minibufexpl 跳转快捷键
" 使用说明："1" 上一个标签
"			"2" 下一个标签
nmap 1 :bp<CR>
nmap 2 :bn<CR>


" ---常规模式下 编辑vimrc文件
if (g:islinux)
	nmap <Leader>ev :e ~/.vimrc<CR>
else
	nmap <Leader>ev :e $vim/_vimrc<CR>
endif

" ---常规模式下 编辑zshrc文件(仅适用于linux)
if (g:islinux)
	nmap <Leader>ez :e ~/.zshrc<CR>
endif

" ---常规模式下 跳到句首或者句尾
" 使用说明："; + e" 跳到句尾
"			"; + h" 跳到句首
nmap ;e $
nmap ;h ^

" ---常规模式下 使用复制缓存寄存器进行粘贴
nmap ;p "0p

" ---常规模式下 重新source .vimrc
nmap ;s :source ~/.vimrc<CR>

" ---常规模式下 tab标签页操作
nmap - :tabp<CR>
nmap = :tabn<CR>


if exists('$TMUX')
    set term=screen-256color
endif


" ---当修改.vimrc并执行保存动作后，自动source该文件
" autocmd BufWritePost .vimrc source ~/.vimrc
" autocmd! BufWritePost *.c normal G

" ---project workspace 配置
" 保存当前工程的vim配置 
" nmap <F11> :mksession! workspace.vim<CR> :wviminfo! workspace.viminfo<CR> :xa<CR>
" 加载上次工程vim配置
" nmap <F12> :source workspace.vim<CR> :rviminfo workspace.viminfo<CR>

" ---不常用命令记录
" :set nonu #不显示行号
" :ccl #关闭quickfix窗口

" VIM CONFIG SET BY huayue_hu*************************************************************************END

