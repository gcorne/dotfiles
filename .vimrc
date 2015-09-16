" auto indenting
set ai

" keep ## lines of history
set history=10000

" show the cursor position
set ruler

" syntax highlighting
syntax on

" set leader used in key bindings
let mapleader = ","

set ignorecase

" if lowercase, case insensitve else case sensitive
set smartcase

" apply substitutions globally
set gdefault

" highlight the last searched term
set hlsearch

" enable incremental search
set incsearch

" clear search highlighting quickly
nnoremap <leader><space> :noh<cr>

" allow a buffer with pending changes to be hidden
set hidden
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

" Enable basic mouse behavior such as resizing buffers.
set mouse=a

function! SetTwoSpace()
	setlocal tabstop=2
	setlocal softtabstop=2
	setlocal shiftwidth=2
	setlocal smarttab
	setlocal expandtab
endfunction
nnoremap <leader>2 :call SetTwoSpace()<CR>

function! SetFourSpace()
	setlocal tabstop=4
	setlocal softtabstop=4
	setlocal shiftwidth=4
	setlocal smarttab
	setlocal expandtab
endfunction
nnoremap <leader>4 :call SetTwoSpace()<CR>

function! SetTabs()
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal softtabstop=4
	setlocal noexpandtab
endfunction

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

" strip all whitespace from current file
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<cr>

" Ack shortcut
nnoremap <leader>a :Ack 

" Tagbar shortcut
nnoremap <leader>t :TagbarToggle<cr>

" List active buffers (requires CtrlP plugin)
nnoremap <leader>b :CtrlPBuffer<CR>

" window navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>g :set number!<CR>:GitGutterToggle<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader>v :vnew

nnoremap <leader>es :Esformatter
vnoremap <leader>es :Esformatter

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

" load Vundle plugins
if filereadable(expand("~/.dotfiles/plugins.vim"))
  source ~/.dotfiles/plugins.vim
endif

if filereadable(expand("~/.dotfiles/plugins-local.vim"))
  source ~/.dotfiles/plugins-local.vim
endif

" install bundles for the first time
if vundle_installing == 1
	echo "Installing Bundles, please ignore key map error messages"
	echo ""
	:PluginInstall
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

" PHP
autocmd Syntax php normal zR

" Tagbar
let g:tagbar_left = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1

let g:tagbar_type_php = {
    \ 'kinds' : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constant definitions:1:0',
        \ 'f:functions',
    \ ],
\ }

"Use jshint for javascript syntax checking
let g:syntastic_javascript_checkers = ["jshint"]
let g:syntastic_json_checkers=["jsonlint"]
let g:syntastic_css_checkers=[""]

autocmd BufEnter *.jsx let b:syntastic_checkers=["jsxhint"]

"GitGutter
"
"Disable by default
let g:gitgutter_enabled = 0

" CtrlP
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_files = 0

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Clean up VimFugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Set filetype for json to json instead of javascript
autocmd BufRead,BufNewFile *.json setlocal filetype=json
autocmd BufRead,BufNewFile *.json setlocal syntax=javascript

" Load local vim config
if filereadable(expand("~/.dotfiles/local.vim"))
	source ~/.dotfiles/local.vim
endif
