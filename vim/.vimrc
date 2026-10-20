" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of
" those settings, you should do it in this file (/etc/vim/vimrc), since
" debian.vim will be overwritten everytime an upgrade of the vim packages
" is performed.
" It is recommended to make changes after sourcing debian.vim since it
" alters the value of the 'compatible' option.

runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" next line enables syntax highlighting by default.

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well

" Uncomment the following to have Vim jump to the last position when
" reopening a file

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set autowrite		" Automatically save before commands like :next and :make
"set mouse=a		" Enable mouse usage (all modes)

"chaoadd:               配置内容
if has("syntax")        " 支持则开语法高亮
  syntax on
endif
filetype plugin indent on   " 按文件类型加载插件和缩进
set background=dark     " 深色背景配色
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif  " 重开文件跳回上次位置
set showmatch           " 显示匹配括号
set ignorecase          " 搜索忽略大小写
set smartcase           " 含大写时区分大小写
set wildmenu 			" 列出补全列表
set wildmode=list:full
set incsearch           " 增量搜索
set hidden              " 切换文件不强制保存

set tabstop=4           " Tab 显示宽度
set shiftwidth=4        " 自动缩进宽度
set autoindent			" 自动缩进
autocmd FileType make setlocal noexpandtab          " Makefile 用真 Tab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2   " JS 缩进 2
autocmd FileType python setlocal tabstop=4 shiftwidth=4       " Python 缩进 4

set number              " 显示行号
set laststatus=2 		" 始终显示状态栏
set showcmd 			" 底部显示待决命令提示
set encoding=utf-8      " 默认编码
set fileencodings=utf-8,gbk,gb2312,latin1   " 编码尝试顺序，防中文乱码
"add_end


let g:plug_url_format = 'https://ghproxy.net/https://github.com/%s.git'
call plug#begin('~/.vim/plugged') " 在这里声明插件

Plug 'preservim/nerdtree'				"文件列表插件
Plug 'preservim/tagbar'                 "右侧结构视图
Plug 'neoclide/coc.nvim', {'branch': 'release'} "自动补全
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 	"fzf文件查找
Plug 'junegunn/fzf.vim'

call plug#end()         "插件内容结束

"插件设置：
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
set completeopt=menu,menuone,noselect
set shortmess+=c

"快捷键设置
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :TagbarToggle<CR>

" Tab 键导航补全
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <C-y> coc#pum#visible() ? coc#pum#confirm() : "\<C-y>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction




" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

