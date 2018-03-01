" don't make vim compatible with vi 
set nocompatible

" Leader
let mapleader = ","
let g:mapleader = ","

" turn on syntax highlighting
syntax on
" and show line numbers
set number

set shell=zsh
set noic
set clipboard=unnamed " pbcopy/pbpaste on OSX
set showcmd " Display the command as we type iti
set whichwrap=h,l,~,[,],<,> " Which caracters to wrap

" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

" reload files changed outside vim
set autoread

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

set mouse=a

" disable netrw since I'm using NERDTree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" enable matchit plugin enhances '%'
runtime macros/matchit.vim

" fuck tabs!
set tabstop=2 " Tab = 2 spaces
set softtabstop=2
set shiftwidth=2
set expandtab " No more tabs, only whitespaces

" backspace won't delete over line breaks, or automatically-inserted indentation
set backspace=indent,eol,start
" enable forward delete
inoremap <C-d> <Del>

" dont't unload buffers when they are abandoned, instead stay in the  background
set hidden

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new buffers
set fileformats=unix,dos

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" screen will not be redrawn while running macros, registers or other non-typed comments
set lazyredraw

" Folds
set foldmethod=marker

" Theme
set termguicolors
set background=dark
set cursorline
colorscheme one

" Status
set laststatus=2
set noshowmode " Mode is included in Lightline

" search
set ignorecase " Ignore case when searching
set smartcase " Smart-case search mode
set incsearch " Start to search as soon as we type
set gdefault " Always search/replace globally
