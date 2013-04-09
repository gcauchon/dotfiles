"---------------------------------------
" @file .vimrc
" @description vim configuration file
" @author Guillaume Cauchon
"---------------------------------------

" Vumble
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
Bundle 'kien/ctrlp.vim'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" vim-scripts repos
Bundle 'l9'
Bundle 'fuzzyfinder'

filetype plugin indent on
"
" brief help
" :bundlelist          - list configured bundles
" :bundleinstall(!)    - install(update) bundles
" :bundlesearch(!) foo - search(or refresh cache first) for foo
" :bundleclean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for faq
" note: comments after bundle command are not allowed..

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

" Police {{{
set guifont=Source\ Code\ Pro:h12
"}}}

" color scheme {{{
 
set background=dark
let g:solarized_bold=1
let g:solarized_contrast="high"
let g:solarized_visibility="normal"
let g:solarized_termcolors=256
colorscheme solarized
 
"}}}
