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
nmap <Leader>v :bdelete<CR>

" Splits
set splitbelow
set splitright

nnoremap <Leader>< <C-W><C-H>
nnoremap <Leader>j <C-W><C-J>
nnoremap <Leader>k <C-W><C-K>
nnoremap <Leader>> <C-W><C-L>

" Remove trailing whitespace
function! g:RemoveTrailingWhitespace()
  %s/\s\+$//e
endfunction

nmap <C-L> :call g:RemoveTrailingWhitespace()<CR>

" QuickFix (ie Search, Linter, etc...)
nmap <Leader>q :copen<CR>
nmap <Leader>Q :cclose<CR>

" Undo/Redo
noremap u <undo>
noremap U :redo<CR>
