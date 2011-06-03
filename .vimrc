set ai                  " auto indenting
set history=100         " keep 100 lines of history
set ruler               " show the cursor position
syntax on               " syntax highlighting

set hlsearch            " highlight the last searched term

filetype plugin on      " use the file type plugins
filetype indent on
filetype on

set background=dark

colorscheme desert
set nobackup
set nowritebackup
set noswapfile

set lines=40
set columns=80
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smarttab
set backspace=indent,eol,start

" Enable incremental search
set incsearch

" Always show status line, even for one window
set laststatus=2

" Jump to matching bracket for 2/10th of a second (works with showmatch)
set matchtime=2

" Round indent to multiple of 'shiftwidth' for > and < commands
set shiftround

" Use 4 spaces for (auto)indent
set shiftwidth=4

" Show (partial) commands (or size of selection in Visual mode) in the status line
set showcmd

" When a bracket is inserted, briefly jump to a matching one
set showmatch

" Ignore certain types of files on completion
set wildignore+=*.o,*.obj,*.pyc,.git


" Remember things between sessions
"
" '20  - remember marks for 20 previous files
" \"50 - save 50 lines for each register
" :20  - remember 20 items in command-line history 
" %    - remember the buffer list (if vim started without a file arg)
" n    - set name of viminfo file
set viminfo='20,\"50,:20,%,n~/.vim/.viminfo

" Set the <Leader> for combo commands
let mapleader = ","

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif


" SuperCollider-related settings

au BufWinEnter,BufNewFile,BufRead *.sc set filetype=supercollider
au BufWinEnter,BufNewFile,BufRead *.sc let &iskeyword="@,48-57,_,192-255" | runtime ftplugin/supercollider.vim
au BufWinEnter,BufNewFile,BufRead *.sc set sw=4 ts=4 autoindent "this line can be changed however you like

"sc help files
au BufWinEnter,BufNewFile,BufRead *.scd set filetype=supercollider
au BufWinEnter,BufNewFile,BufRead *.scd let &iskeyword="@,48-57,_,192-255,-,|" | runtime ftplugin/supercollider.vim
au BufWinEnter,BufNewFile,BufRead *.scd set sw=4 ts=4 autoindent "this line can be changed however you like

"required for matching
au Filetype supercollider,supercollider_help let b:match_skip = 's:scComment\|scString\|scSymbol'
au Filetype supercollider,supercollider_help let b:match_words = '(:),[:],{:}'
