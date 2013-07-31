"---------------------------------------
" @file .vimrc
" @description vim configuration file
" @author Guillaume Cauchon
"---------------------------------------

" Vumble
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required! 
Bundle 'gmarik/vundle'

" Solarized
Bundle 'altercation/vim-colors-solarized'

" Command-T
Bundle 'git://git.wincent.com/command-t.git'
map <C-t> :CommandT<CR>
let g:CommandTCancelMap='<C-x>'
let g:CommandTMatchWindowAtTop=1

filetype plugin indent on

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

