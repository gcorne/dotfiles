Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
if has('nvim')
  Plug 'ibhagwan/fzf-lua'
else
  Plug 'junegunn/fzf.vim'
endif
Plug 'dense-analysis/ale'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-unimpaired'
Plug 'editorconfig/editorconfig-vim'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


Plug 'github/copilot.vim'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/goyo.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Clojure bundles
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'

" Sass/CSS
Plug 'gcorne/vim-sass-lint'

" JavaScript/Typescript
Plug 'mustache/vim-mode'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'nono/vim-handlebars'
Plug 'leafgarland/typescript-vim'

" GraphQL
Plug 'jparise/vim-graphql'

" Rust
Plug 'rust-lang/rust.vim'

" Kotlin
Plug 'udalov/kotlin-vim'
