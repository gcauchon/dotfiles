call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline' " lean & mean status/tabline
Plug 'vim-airline/vim-airline-themes'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy file, buffer, mru, tag, ... finder
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround' " easily delete, change and add such surroundings in pairs (ie. cs'<p> to change from ' to <p>...</p>)
Plug 'Raimondi/delimitMate' " insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'ervandew/supertab' " insert mode completions with Tab
Plug 'jszakmeister/vim-togglecursor' " toggle the cursor shape in Insert mode
Plug 'vim-scripts/camelcasemotion' " navigate thru CamelCase or underscore_notation (ie: ,w ,e & ,b)

" Filetype-specific plugins
Plug 'mattn/emmet-vim', { 'for': ['html', 'eruby', 'ruby', 'scss', 'css', 'yaml', 'haml', 'less', 'blade'] }
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss'] }
Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
Plug 'lukaszb/vim-web-indent', { 'for': ['html', 'javascript'] }
Plug 'plasticboy/vim-markdown', { 'for': ['mkd'] }
Plug 'othree/html5.vim', { 'for': ['html', 'eruby'] }
Plug 'pangloss/vim-javascript' " For some reason, we cannot use `'for': 'javascript'` here because it breaks indent
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }

call plug#end()

" Settings
source $HOME/.vim/config/settings.vim
source $HOME/.vim/config/plugins.vim
source $HOME/.vim/config/filetype.vim

