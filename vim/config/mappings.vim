" ESC
inoremap ,, <Esc>

" Tabs
vnoremap < <gv
vnoremap > >gv|
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv

nmap <Leader>x "_x
nmap <Leader>d "_d
nmap <Leader>dd "_dd

" Buffer navigation
nmap > :bnext<CR>
nmap < :bprevious<CR>
nmap <Leader>c :bdelete<CR>

" Remove trailing whitespace
nmap <C-L> :call g:RemoveTrailingWhitespace()<CR>

" Current file full path
nmap <Leader>p :echo expand('%:p')<CR>
