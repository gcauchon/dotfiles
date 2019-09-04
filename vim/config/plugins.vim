" fzf 
map <Leader>p :Files<CR>
map <Leader>o :Buffers<CR>
map <Leader>m :MRU<CR>
map <Leader>f :Rg<CR>
map <Leader>g :GFiles<CR>
map <Leader>l :Lines<CR>

" NERDtree
let g:netrw_fastbrowse = 0
let g:netrw_liststyle = 3

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
\ "Deleted"   : "x",
\ "Dirty"     : "!",
\ "Clean"     : "✓",
\ "Unknown"   : "?"
\ }

" lightline
let g:lightline = {
\  'colorscheme': 'one',
\}

" Grepper
let g:grepper = {}
let g:grepper.tools = ['rg', 'ack', 'grep', 'git']
