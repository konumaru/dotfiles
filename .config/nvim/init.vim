"*****************************************************************************
"" Path configs
"*****************************************************************************"
" reset augroup
augroup MyAutoCmd
    autocmd!
augroup END

" ENV
let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let $DATA = empty($XDG_DATA_HOME) ? expand('$HOME/.local/share') : $XDG_DATA_HOME

let g:python_host_prog = '$HOME/.rye/shims/python'
let g:python3_host_prog = '$HOME/.rye/shims/python3'

" Load rc file
function! s:load(file) abort
    let s:path = expand('$CONFIG/nvim/' . a:file)

    if filereadable(s:path)
        execute 'source' fnameescape(s:path)
    endif
endfunction

call s:load('rc/plugins.vim')

" Required:
filetype plugin indent on
syntax enable

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"

set clipboard+=unnamed

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set shiftwidth=4
set softtabstop=0
set autoindent
set expandtab
set smartindent

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac


"*****************************************************************************
"" Visual Settings
"*****************************************************************************
set hls
set list
set wrap
set number
set splitright
set textwidth=0
set colorcolumn=120


"*****************************************************************************
"" Mappings
"*****************************************************************************
inoremap jj <Esc>
map <C-l> gt
map <C-h> gT


"*****************************************************************************
"" Markdown
"*****************************************************************************
au BufNewFile,BufRead *.md :set filetype=markdown
autocmd FileType markdown setlocal shiftwidth=2
autocmd FileType markdown setlocal tabstop=2
autocmd FileType markdown setlocal expandtab
