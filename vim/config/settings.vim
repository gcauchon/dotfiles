" Leader
let mapleader = ","
let g:mapleader = ","

set shell=fish
set mouse=a             " Allow mouse in all modes
set clipboard=unnamed   " pbcopy/pbpaste on OSX
set showcmd             " Display command as I type
set number              " Show line numbers
set showmatch           " Highlight matching brace
set whichwrap=h,l,~,[,],<,> " Which caracters to wrap
syntax on               " Syntax highlighting

" Detect file types and load plugins
filetype on
filetype plugin on
filetype indent on
          
" Encoding is UTF-8
set encoding=utf-8
set fileencoding=utf-8

" No tabs!
set expandtab           " Use spaces instead of tabs
set shiftwidth=2        " Number of auto-indent spaces
set softtabstop=2       " Number of spaces per Tab
set tabstop=2
set backspace=indent,eol,start " backspace delete over line breaks and indentation

" Theme
" colorscheme onedark
colorscheme molokai
set background=dark
set cursorline

" Status
set laststatus=2
set noshowmode          " Mode is included in Lightline

" Search
set ignorecase          " Ignore case when searching
set smartcase           " Smart-case search mode
set incsearch           " Start to search as soon as we type
