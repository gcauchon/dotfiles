" don't make vim compatible with vi 
set nocompatible

" Leader
let mapleader = ","
let g:mapleader = ","

set shell=fish
set mouse=a             " Allow mouse in all modes
set clipboard=unnamed   " pbcopy/pbpaste on OSX
set autoread            " Reload files changed outside vim
set showcmd             " Display the command as we type iti
set number              " Show line numbers
set whichwrap=h,l,~,[,],<,> " Which caracters to wrap
syntax on               " Syntax highlighting
set fileformat=unix     " Use Unix line endings
set fileformats=unix,dos

" Detect file types and load plugins
filetype on
filetype plugin on
filetype indent on
          
" Encoding is UTF-8
set encoding=utf-8
set fileencoding=utf-8

" No tabs!
set tabstop=2           " 1 tab -> 2 spaces
set softtabstop=2       " 1 tab -> 2 spaces
set expandtab           " No more tabs, only whitespaces
set backspace=indent,eol,start " backspace delete over line breaks and indentation

" Theme
set termguicolors
set background=dark
set cursorline
colorscheme one

" Status
set laststatus=2
set noshowmode          " Mode is included in Lightline

" Search
set ignorecase          " Ignore case when searching
set smartcase           " Smart-case search mode
set incsearch           " Start to search as soon as we type
set gdefault            " Always search/replace globally
