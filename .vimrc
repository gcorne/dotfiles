" auto indenting
set autoindent

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
set smarttab
set expandtab
set backspace=indent,eol,start
set wrap

" Open vertical splits on the right
set splitright

" Enable basic mouse behavior such as resizing buffers.
set mouse=a

set termguicolors

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
if !has('nvim')
  set viminfo='100,\"50,:1000,%,n~/.vim/.viminfo
endif


" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif



" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


" load plugins
call plug#begin('~/.vim/plugged')
if filereadable(expand("~/dotfiles/plugins.vim"))
  source ~/dotfiles/plugins.vim
endif

if filereadable(expand("~/dotfiles/plugins-local.vim"))
  source ~/dotfiles/plugins-local.vim
endif
call plug#end()

colorscheme base16-tomorrow-night

let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_tomorrow_night'

" strip all whitespace from current file
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<cr>

" Ack shortcut
nnoremap <leader>a :Ack<space>

" List active buffers
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

tnoremap <leader><Esc> <C-\><C-n>
nnoremap <leader>m :Goyo

nnoremap <leader>g :set number!<CR>:GitGutterToggle<CR>
nnoremap <leader>v :vnew
nnoremap <leader>p :ALEFix<CR>

" fzf / ripgrep

let $FZF_DEFAULT_COMMAND='rg --files'
let $FZF_DEFAULT_OPTS="--multi --bind ctrl-a:select-all,ctrl-d:deselect-all"

let g:ctrlp_cmd = 'Files'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-k': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

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

" Set filetype for json to json instead of javascript for linting
autocmd BufRead,BufNewFile *.json setlocal filetype=json
autocmd BufRead,BufNewFile *.json setlocal syntax=javascript

autocmd BufRead,BufNewFile *.jsx setlocal filetype=javascript
autocmd BufRead,BufNewFile *.jsx setlocal syntax=javascript

autocmd BufRead,BufNewFile *.mjs setlocal filetype=javascript
autocmd BufRead,BufNewFile *.mjs setlocal syntax=javascript

autocmd BufRead,BufNewFile *.cjs setlocal filetype=javascript
autocmd BufRead,BufNewFile *.cjs setlocal syntax=javascript

autocmd BufRead,BufNewFile *.esnext setlocal filetype=javascript
autocmd BufRead,BufNewFile *.esnext setlocal syntax=javascript

autocmd BufRead,BufNewFile *.lyaml setlocal filetype=yaml

autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile gitcommit setlocal spell


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
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap K :ALEHover<CR>
nmap <silent> <leader>aj :ALENext<CR>
nmap <silent> <leader>ak :ALEPrevious<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <leader>rn :ALERename<CR>
nnoremap <leader>qf :ALECodeAction<CR>

autocmd FileType typescript map <buffer> <c-]> :ALEGoToDefinition<CR>
autocmd FileType typescriptreact map <buffer> <c-]> :ALEGoToDefinition<CR>

let g:ale_fixers = {
\ 'javascript': ['prettier', 'eslint'],
\ 'typescript': ['prettier', 'eslint'],
\ 'typescriptreact': ['prettier', 'eslint'],
\ 'json': ['prettier'],
\}

let g:ale_fix_on_save = 1
let g:ale_virtualtext_cursor = 'disabled'

let base16colorspace=256

" airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'tomorrow'


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' '
let g:airline_symbols.dirty = ' ⚡'

" markdown
let g:vim_markdown_folding_disabled = 1

if has('nvim')
  :lua require('fzf-lua').setup({'fzf-vim'})
endif

" Load local vim config
if filereadable(expand("~/dotfiles/local.vim"))
  source ~/dotfiles/local.vim
endif
