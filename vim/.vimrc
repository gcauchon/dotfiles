"---------------------------------------
" @file .vimrc
" @description vim configuration file
" @author Guillaume Cauchon
"---------------------------------------

" Vumble
set nocompatible
filetype off

" spaces/tabs indenting
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent

set number
set ruler

" status bar
set statusline=file=%F%m%r%h%w\ format=%{&ff}\ type=%Y\ (ascii=\%03.3b/hex=\%02.2B)\ [x,y]=%l/%L,%v\ [%p%%] 
set laststatus=2

" police {{{
set guifont=Source\ Code\ Pro:h12
"}}}

" syntax {{{
syntax enable
set background=dark
colorscheme solarized
"}}}

