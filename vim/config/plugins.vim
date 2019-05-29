" CtrlP
map <Leader>p :CtrlP $(pwd)<CR>
map <Leader>P :CtrlPClearCache<CR>:CtrlP $(pwd)<CR>
map <Leader>l :CtrlP %:p:h<CR>
map <Leader>o :CtrlPBuffer<CR>
map <Leader>m :CtrlPMRU<CR>
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {
\  'dir':  '\v(^|\/)(\.git|\.elixir_ls|deps|node_modules|vendor|_build|dist)$',
\  'file':  '\v(^|\/)(\.DS_Store|.*\.js\.map)$',
\}

" NERDtree
let NERDTreeShowHidden=1
let NERDTreeShowGitStatus=1
map <Leader>f :NERDTreeFind<CR>
map <Leader>t :NERDTreeToggle<CR>

let g:NERDTreeIndicatorMapCustom = {
\ "Modified"  : "*",
\ "Staged"    : "$",
\ "Untracked" : "?",
\ "Renamed"   : "",
\ "Unmerged"  : "═",
\ "Deleted"   : "✖",
\ "Dirty"     : "!",
\ "Clean"     : "✔︎",
\ "Unknown"   : "?"
\ }

" lightline
let g:lightline = {
\  'colorscheme': 'one',
\}

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

" ALE settings
" ----------------------------------------------------------------------------------------------------
let g:ale_sign_error = 'XX'
let g:ale_sign_warning = '!!'
let g:ale_echo_msg_format = '[%severity%] %s'
"let g:ale_set_quickfix = 1
"let g:ale_open_list = 1
let g:ale_list_window_size = 5
let g:ale_linters = {
\   'elixir': ['credo', 'elixir-ls'],
\   'javascript': ['eslint'],
\   'typescript': ['tslint', 'tsserver'],
\   'ruby': ['rubocop'],
\   'css': ['stylelint'],
\   'scss': ['stylelint']
\}
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'elixir': ['mix_format'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier']
\}
let g:ale_elixir_elixir_ls_release = '/Users/gcauchon/Projects/elixir-ls/rel'

nmap <Leader>ad :ALEGoToDefinition<CR>
nmap <Leader>ah :ALEHover<CR>
nmap <Leader>ar :ALEFindReferences<CR>
