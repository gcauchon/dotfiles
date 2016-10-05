" don't make vim compatible with vi 
set nocompatible

" turn on syntax highlighting
syntax on
" and show line numbers
set number

" make vim try to detect file types and load plugins for them
filetype on
filetype plugin on
filetype indent on

" reload files changed outside vim
set autoread

" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" enable matchit plugin enhances '%'
runtime macros/matchit.vim

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

" set leader key
let mapleader = ","
let g:mapleader = ","

" Folds
set foldmethod=marker

" Status {{{
set laststatus=2
set noshowmode " Mode is included in Lightline

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'component': { 'readonly': '%{&readonly?"X":""}' },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '|', 'right': '|' } 
\ }
"}}}

" Theme {{{
colorscheme solarized
set background=dark
"}}}

"
set shell=zsh
set clipboard=unnamed " pbcopy/pbpaste on OSX
set showcmd " Display the command as we type it
set ignorecase " Ignore case when searching
set smartcase " Smart-case search mode
set incsearch " Start to search as soon as we type
set ts=2 " Tab = 4 spaces
set sw=2 " Shift size
set sts=2 " Short tab stop
set et " Use spaces instead of tabs
set whichwrap=h,l,~,[,],<,> " Which caracters to wrap
set gdefault " Always search/replace globally
set ambiwidth=double
