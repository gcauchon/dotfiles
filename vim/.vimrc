"---------------------------------------
" @file .vimrc
" @description vim configuration file
" @author Guillaume Cauchon
"---------------------------------------

" Vumble
set nocompatible               " be iMproved
filetype off                   " required!
set backspace=indent,eol,start

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required! 
Bundle 'gmarik/vundle'

" Solarized
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized

Bundle 'Lokaltog/powerline'
Bundle 'Valloric/YouCompleteMe'

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
set smartindent

set number
set ruler

" police {{{
set guifont=Source\ Code\ Pro:h12
"}}}

" syntax {{{
syntax enable

" Solarized
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termtrans = 1
set background=dark
colorscheme solarized
"}}}

