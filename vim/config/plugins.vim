" vim-startify
let g:startify_custom_header = []

" fzf 
let g:netrw_fastbrowse = 0

map <Leader>f :Rg<CR>
map <Leader>p :GFiles<CR>
map <Leader>o :Files<CR>
map <Leader>, :Buffers<CR>
map <Leader>m :MRU<CR>
map <Leader>l :Lines<CR>

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

" Grepper
let g:grepper = {}
let g:grepper.tools = ['rg', 'ack', 'grep', 'git']
