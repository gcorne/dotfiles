set ai                  " auto indenting
set history=100000      " keep ## lines of history
set ruler               " show the cursor position
syntax on               " syntax highlighting

let mapleader = ","

set ignorecase
set smartcase			" if lowercase, case insensitve else case sensitive
set gdefault			" apply substitutions globally
set hlsearch            " highlight the last searched term
set incsearch			" Enable incremental search

" clear search highlighting quickly
nnoremap <leader><space> :noh<cr>

set hidden				" allow a buffer with pending changes to be hidden
set background=dark

" disable error sounds
set noerrorbells
set visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set nobackup
set nowritebackup
set noswapfile

set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set noexpandtab
set backspace=indent,eol,start
set wrap

function! SetTwoSpace()
	setlocal tabstop=2
	setlocal softtabstop=2
	setlocal shiftwidth=2
	setlocal smarttab
	setlocal expandtab
endfunction
nnoremap <leader>2 :call SetTwoSpace()

function! SetFourSpace()
	setlocal tabstop=4
	setlocal softtabstop=4
	setlocal shiftwidth=4
	setlocal smarttab
	setlocal expandtab
endfunction
nnoremap <leader>4 :call SetTwoSpace()
" Search up the directory tree looking for tags file
set tags=./tags;/

set winminheight=0
set winminwidth=0

" Always show status line, even for one window
set laststatus=2

" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Ignore certain types of files on completion
set wildignore+=*.o,*.obj,*.pyc,.git,.svn

" Write with sudo ":w!!"
cnoremap w!! w !sudo tee % >/dev/null

" Change how j and k behave when a line wraps 
nmap j gj
nmap k gk

" Remember things between sessions
"
" '100  - remember marks for 100 previous files
" \"50 - save 50 lines for each register
" :1000  - remember 1000 items in command-line history
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='100,\"50,:1000,%,n~/.vim/.viminfo

" Change how j and k behave when a line wraps
nmap j gj
nmap k gk

" strip all whitespace from current file
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<cr>

" Ack shortcut
nnoremap <leader>a :Ack 

" TList shortcut
nnoremap <leader>t :Tlist<cr>

" List active buffers (requires CtrlP plugin)
nnoremap <leader>b :CtrlPBuffer<cr>

" window navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

filetype off
" Setting up Vundle - the vim plugin bundler
let vundle_installing=0
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')

if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
	let vundle_installing=1
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/syntastic'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
" Git integration
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
" Bundle 'majutsushi/tagbar'
" Bundle 'techlivezheng/tagbar-phpctags'

" PHP Bundles
" autocomplete for PHP
"Bundle 'shawncplus/phpcomplete.vim'
" debugger for PHP+Xdebug
Bundle 'brookhong/DBGPavim.git'
" improved PHP code folding
"Bundle 'gcorne/phpfolding.vim'
Bundle 'spf13/PIV'
Bundle 'ervandew/supertab'
" ruby bundles
" Bundle 'vim-ruby/vim-ruby'
" Bundle 'm2ym/rsense'

" Clojure bundles
Bundle 'tpope/vim-fireplace'
Bundle 'guns/vim-clojure-static'

"...All your other bundles...
if vundle_installing == 1
	echo "Installing Bundles, please ignore key map error messages"
	echo ""
	:BundleInstall
endif

filetype plugin on " use the file type plugins
filetype indent on
filetype on

colorscheme Tomorrow-Night

" clojure
let vimclojure#FuzzyIndent=1
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = $HOME . "/bin/ng"

" TagList
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
" Displaying tags for only one file
let Tlist_Show_One_File = 1
" let Tlist_Process_File_Always = 1
" set the names of flags
let tlist_php_settings = 'php;c:class;f:function;d:constant'
let tlist_javascript_settings = 'javascript;o:object;f:function'
" close all folds except for current file
let Tlist_File_Fold_Auto_Close = 1
" make tlist pane active when opened
let Tlist_GainFocus_On_ToggleOpen = 1
" width of window
let Tlist_WinWidth = 40
" close tlist when a selection is made
let Tlist_Close_On_Select = 1
let Tlist_Display_Tag_Scope = 1

" CtrlP
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files = 0


" VimFugitive
autocmd BufReadPost fugitive://* set bufhidden=delete


