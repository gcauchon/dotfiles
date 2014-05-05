"---------------------------------------
" @file .vimrc
" @description vim configuration file
" @author Guillaume Cauchon
"---------------------------------------
set nocompatible               " be iMproved
filetype off                   " required!

set backspace=indent,eol,start

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
"Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'Solarized'
Plugin 'tomasr/molokai'

call vundle#end()
filetype plugin indent on

" spaces/tabs indenting
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent
set smartindent

set number
set noruler

" Command-T {{{
"map <C-t> :CommandT<CR>
"let g:CommandTCancelMap='<C-x>'
"let g:CommandTMatchWindowAtTop=1
" }}}

" police {{{
set guifont=Source\ Code\ Pro:h12
"}}}

" syntax {{{
syntax enable
" Solarized
let g:solarized_termtrans=1
let g:solarized_termcolors=256
"set background=dark
"colorscheme solarized
colorscheme molokai
"}}}

" statusline
set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P

