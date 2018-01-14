" CtrlP
map <Leader>p :CtrlP $(pwd)<CR>
map <Leader>P :CtrlPClearCache<CR>:CtrlP $(pwd)<CR>
map <Leader>l :CtrlP %:p:h<CR>
map <Leader>o :CtrlPBuffer<CR>
map <Leader>m :CtrlPMRU<CR>
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v(^|\/)(deps|log|vendor|tmp|_build|node_modules|\.git|dist)$',
\ 'file':  '\v(^|\/)(\.DS_Store|.*\.js\.map)$',
\}

" NERDtree
let NERDTreeShowHidden=1
map <Leader>f :NERDTreeFind<CR>
map <Leader>t :NERDTreeToggle<CR>

" Ack
let g:ackprg = 'rg --no-heading --color=never --column --line-number'

" Emmet
let g:user_emmet_leader_key = ';'
let g:user_emmet_expandabbr_key = ';;'
let g:user_emmet_settings = {
\  'indentation': '  ',
\  'javascript' : {
\    'extends' : 'jsx',
\  }
\}

" vim-jsx
let g:jsx_ext_required = 0

" Neomake
let g:neomake_open_list=2
let g:neomake_list_height=4
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_html_enabled_makers = ['tidy']
let g:neomake_html_tidy_maker = { 'args': ['-e', '-q'], 'errorformat': 'line %l column %c - %m' }
let g:neomake_scss_enabled_makers = ['stylelint']
let g:neomake_scss_stylelint_maker = { 'args': ['--no-color'], 'errorformat': '%+P%f,%*\s%l:%c  %t  %m,%-Q' }
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_elixir_enabled_makers = ['credo']
let g:neomake_elixir_credo_maker = { 'exe': 'mix', 'args': ['credo', '%:p', '--format=oneline', '--strict'], 'errorformat': '[%t] %. %f:%l %m' }

augroup NeoMake
  autocmd BufWritePost * Neomake
augroup END
