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
set shiftwidth=2
set softtabstop=2
set autoindent
set smarttab
set expandtab
set backspace=indent,eol,start
set wrap

" Enable basic mouse behavior such as resizing buffers.
set mouse=a

function! SetTwoSpace()
	setlocal shiftwidth=2
	setlocal softtabstop=2
	setlocal smarttab
	setlocal expandtab
endfunction
nnoremap <leader>2 :call SetTwoSpace()<CR>

function! SetFourSpace()
	setlocal shiftwidth=4
	setlocal softtabstop=4
	setlocal smarttab
	setlocal expandtab
endfunction
nnoremap <leader>4 :call SetFourSpace()<CR>

function! SetTabs()
	setlocal shiftwidth=4
	setlocal softtabstop=4
	setlocal noexpandtab
endfunction
nnoremap <leader>0 :call SetTabs()<CR>

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


"nnoremap <C-]> :ALEGoToDefinition<CR>

nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>g :set number!<CR>:GitGutterToggle<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader>v :vnew
nnoremap <leader>p :ALEFix<CR>


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

" Set filetype for json to json instead of javascript for linting
autocmd BufRead,BufNewFile *.json setlocal filetype=json
autocmd BufRead,BufNewFile *.json setlocal syntax=javascript

autocmd BufRead,BufNewFile *.jsx setlocal filetype=javascript
autocmd BufRead,BufNewFile *.jsx setlocal syntax=javascript

autocmd BufRead,BufNewFile *.lyaml setlocal filetype=yaml

" Check for a project specific version of eslint
function SyntasticESlintChecker()
  let l:npm_bin = ''
  let l:eslint = 'eslint'

  if executable('npm')
      let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/eslint')
    let l:eslint = l:npm_bin . '/eslint'
  endif

  let b:syntastic_javascript_eslint_exec = l:eslint
endfunction

" Check for a project specific version of sasslint
function SyntasticSassChecker()
  let l:npm_bin = ''
  let l:sass_lint = 'sass-lint'

  if executable('npm')
      let l:npm_bin = split(system('npm bin'), '\n')[0]
  endif

  if strlen(l:npm_bin) && executable(l:npm_bin . '/sass-lint')
    let l:sass_lint = l:npm_bin . '/sass-lint'
  endif

  echo l:sass_lint
  let b:syntastic_sass_sasslint_exec = l:sass_lint
endfunction


"Use eslint for javascript syntax checking
let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_json_checkers=["jsonlint"]
let g:syntastic_css_checkers=[""]
let g:syntastic_sass_checkers=["sasslint"]
let g:syntastic_scss_checkers=["sasslint"]

autocmd FileType javascript :call SyntasticESlintChecker()
autocmd FileType sass :call SyntasticSassChecker()

function! QuickFixOpenAll()
  if empty(getqflist())
	return
  endif
  let s:prev_val = ""
  for d in getqflist()
	let s:curr_val = bufname(d.bufnr)
	if (s:curr_val != s:prev_val)
		exec "edit " . s:curr_val
	endif
	let s:prev_val = s:curr_val
  endfor
endfunction

command! QuickFixOpenAll call QuickFixOpenAll()

"GitGutter
"
"Disable by default
let g:gitgutter_enabled = 0

" CtrlP
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_max_files = 0

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Clean up VimFugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

"Ale
let g:ale_fixers = {
\ 'javascript': ['prettier'],
\}

" Load local vim config
if filereadable(expand("~/.dotfiles/local.vim"))
	source ~/.dotfiles/local.vim
endif
