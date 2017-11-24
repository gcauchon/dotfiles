" ESC
noremap ,, <Esc>

" Indentation
vnoremap < <gv
vnoremap > >gv|
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv

" Destructive 'delete'
nmap <Leader>x "_x
nmap <Leader>d "_d
nmap <Leader>dd "_dd

" Buffer navigation
nmap > :bnext<CR>
nmap < :bprevious<CR>
nmap <Leader>c :bdelete<CR>

" Splits
set splitbelow
set splitright

" Remove trailing whitespace
nmap <C-L> :call g:RemoveTrailingWhitespace()<CR>

" QuickFix (ie Search, Linter, etc...)
nmap <Leader>q :copen<CR>
nmap <Leader>Q :cclose<CR>
