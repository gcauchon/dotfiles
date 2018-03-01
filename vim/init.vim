call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim' " fuzzy file, buffer, mru, tag, ... finder
Plug 'tpope/vim-surround' " easily delete, change and add such surroundings in pairs (ie. cs'<p> to change from ' to <p>...</p>)
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab' " insert mode completions with Tab
Plug 'jszakmeister/vim-togglecursor' " toggle the cursor shape in Insert mode
Plug 'vim-scripts/camelcasemotion' " navigate thru CamelCase or underscore_notation (ie: ,w ,e & ,b)
Plug 'rizzatti/dash.vim' "search for terms using the excellent Dash.app
Plug 'scrooloose/nerdtree' "A tree explorer plugin for vim
Plug 'mileszs/ack.vim' "Run your favorite search tool from Vim, with an enhanced results list
Plug 'neomake/neomake' "Async :make and linting framework for Neovim
Plug 'gcauchon/vim-one' "Adaptation of one-light and one-dark colorschemes for Vim
Plug 'itchyny/lightline.vim' " light and configurable statusline/tabline

" Filetype-specific plugins
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
Plug 'othree/html5.vim', { 'for': ['html', 'eruby'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss'] }
Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
Plug 'slashmili/alchemist.vim', { 'for': ['elixir', 'eelixir'] }
Plug 'lukaszb/vim-web-indent', { 'for': ['html', 'javascript'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'jparise/vim-graphql', { 'for': ['graphql'] }
Plug 'plasticboy/vim-markdown', { 'for': ['mkd'] }
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }

call plug#end()

" Settings
source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/functions.vim
source ~/.config/nvim/config/mappings.vim
source ~/.config/nvim/config/filetype.vim
source ~/.config/nvim/config/plugins.vim

