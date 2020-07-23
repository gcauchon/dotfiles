" --------------- "
" CamelCaseMotion "
" --------------- "
map <silent>w <plug>CamelCaseMotion_w
map <silent>b <plug>CamelCaseMotion_b
map <silent>e <plug>CamelCaseMotion_e

" --- "
" fzf "
" --- "
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.6, 'xoffset': 1}}

map <leader>p :GFiles<CR>
map <leader>o :Buffers<CR>
map <leader>l :Files<CR>

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" --------- "
" lightline "
" --------- "
let g:lightline = {'colorscheme': 'one'}

" ------- "
" Grepper "
" ------- "
let g:grepper = {}
let g:grepper.tools = ['rg', 'ack', 'grep', 'git']

map <leader>g :Grepper<CR>

" --- "
" coc "
" --- "
set hidden          " If hidden is not set, TextEdit might fail.
set nobackup        " Some servers have issues with backup files, see #649
set nowritebackup
set updatetime=300  " Bad experience for diagnostic messages with default (ie 4000)
set shortmess+=c    " Don’t give |ins-completion-menu| messages
set signcolumn=yes  " Always show signcolumns

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" use <c-space> for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use <Tab> and <S-Tab> to navigate the completion list

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <cr> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Explorer
nmap <leader>t :CocCommand explorer<CR>
nmap <leader>f :CocCommand explorer --no-toggle<CR>

" Format
nmap <leader>F :call CocAction('format')<CR>

" Gotos
nmap <silent>gd <plug>(coc-definition)
nmap <silent>gt <plug>(coc-type-definition)
nmap <silent>gi <plug>(coc-implementation)
nmap <silent>gr <plug>(coc-references)

" Outline
nmap <leader>O :CocList outline<CR>

" Documentation
nnoremap <silent>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
