" ESC
inoremap ,, <Esc>

" Tabs
vnoremap < <gv
vnoremap > >gv|
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv

" Buffer navigation
nmap > :bnext<CR>
nmap < :bprevious<CR>
nmap <Leader>d :bdelete<CR>

" Remove trailing whitespace
nmap <C-L> :call g:RemoveTrailingWhitespace()<CR>

" Current file full path
nmap <Leader>p :echo expand('%:p')<CR>
