" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 'ra'
nnoremap <c-p> :CtrlP<CR>
nnoremap <c-o> :CtrlPBuffer<CR>

" NERDtree
let NERDTreeShowHidden=1
map <c-t> :NERDTreeToggle<CR>

"emmet settings
" ----------------------------------------------------------------------------------------------------
let g:user_emmet_leader_key = ';'
let g:user_emmet_expandabbr_key = ';;'
let g:user_emmet_settings = {
\  'indentation': '  '
\}

" Neomake settings
" ----------------------------------------------------------------------------------------------------
let g:neomake_open_list=2
let g:neomake_list_height=4
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_scss_enabled_makers = ['stylelint']
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_html_enabled_makers = ['tidy']
let g:neomake_elixir_enabled_makers = []
let g:neomake_scss_stylelint_maker = { 'args': ['--no-color'], 'errorformat': '%+P%f,%*\s%l:%c  %t  %m,%-Q' }
let g:neomake_html_tidy_maker = { 'args': ['-e', '-q'], 'errorformat': 'line %l column %c - %m' }
