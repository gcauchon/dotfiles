call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'

call plug#end()

syntax on

filetype on
filetype plugin indent on
filetype indent on

let mapleader = ","

set shell=zsh

" Always use UTF-8
set encoding=utf-8
set fileencoding=utf-8

" Look & Feel
set showcmd " Display the command as we type it
set showmode " Display the current mode
set ignorecase " Ignore case when searching
set smartcase " Smart-case search mode
set incsearch " Start to search as soon as we type
set hlsearch " Highlight matching search result
set gdefault " Always search/replace globally
set mouse= " Never use the mouse
set number " Show line numbers
set ts=2 " A tab = 4 spaces
set sw=2 " Shift width
set sts=2 " Short tab stop
set et " Use spaces instead of tabs
set title " Display filename in window title
set showmatch " Show matching parentheses
set noautoindent " Code auto-indent
set nosmartindent " Smart code auto-indent

" theme
set t_Co=256
set background=dark
colorscheme molokai

" status
set laststatus=2

set statusline=[\ %F%m%r%h%w
set statusline+=\ %{fugitive#statusline()}
set statusline+=%=
set statusline+=col:\ %c\ line:\ %l/%L\ ]
