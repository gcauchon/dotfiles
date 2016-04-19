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

" ---------------------- CUSTOMIZATION ----------------------
"  The following are some extra mappings/configs to enhance my personal
"  VIM experience

" set , as mapleader
let mapleader = ","

" Status line {{{
set statusline=%<%t\ %y\ %{&ff}
set statusline+=\ %{&modified?'\ (modified)':'\ '}
set statusline+=%=\ col:%c%V\ line:%l\/%L\ %P
set laststatus=2
" }}}

" Theme {{{
colorscheme monokai
set background=dark
"}}}


