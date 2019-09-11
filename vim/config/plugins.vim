" CamelCaseMotion
map <silent>w <plug>CamelCaseMotion_w
map <silent>b <plug>CamelCaseMotion_b
map <silent>e <plug>CamelCaseMotion_e

" fzf 
map <leader>p :GFiles<CR>
map <leader>o :Buffers<CR>
map <leader>l :Files<CR>
map <leader>m :MRU<CR>
map <leader>f :Rg<CR>

" lightline
let g:lightline = {
\  'colorscheme': 'one',
\}

" Grepper
let g:grepper = {}
let g:grepper.tools = ['rg', 'ack', 'grep', 'git']

map <leader>g :Grepper<CR>

" COC
set hidden          " If hidden is not set, TextEdit might fail.
set nobackup        " Some servers have issues with backup files, see #649
set nowritebackup
set updatetime=300  " Bad experience for diagnostic messages with default (ie 4000)
set shortmess+=c    " Don’t give |ins-completion-menu| messages
set signcolumn=yes  " Always show signcolumns

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent>gd <plug>(coc-definition)
nmap <silent>gt <plug>(coc-type-definition)
nmap <silent>gi <plug>(coc-implementation)
nmap <silent>gr <plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <plug>(coc-rename)

" Remap for format selected region
xmap <leader>f <plug>(coc-format-selected)
nmap <leader>f <plug>(coc-format-selected)

augroup cocgroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)
