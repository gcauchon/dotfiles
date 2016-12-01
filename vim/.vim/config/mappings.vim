" set leader key
let mapleader = ","
let g:mapleader = ","

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'c'
nnoremap <c-p> :CtrlP<CR>
nnoremap <c-o> :CtrlPBuffer<CR>

" Tabs
vnoremap < <gv
vnoremap > >gv|
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
