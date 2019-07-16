call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim' "Fuzzy file, buffer, mru, tag, ... finder
Plug 'tpope/vim-surround' "Easily delete, change and add such surroundings in pairs (ie. cs'<p> to change from ' to <p>...</p>)
Plug 'tpope/vim-commentary' "Comment stuff out
Plug 'tpope/vim-fugitive' "Wrapper so awesome, it should be illegal
Plug 'airblade/vim-gitgutter' "Shows a git diff in the gutter (sign column) and stages/undoes hunks.
Plug 'jiangmiao/auto-pairs' "Insert or delete brackets, parens, quotes in pair
Plug 'ervandew/supertab' "Insert mode completions with Tab
Plug 'jszakmeister/vim-togglecursor' "Toggle the cursor shape in Insert mode
Plug 'vim-scripts/camelcasemotion' "Navigate thru CamelCase or underscore_notation (ie: ,w ,e & ,b)
Plug 'scrooloose/nerdtree' "A tree explorer plugin for vim
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'mileszs/ack.vim' "Run your favorite search tool from Vim, with an enhanced results list
Plug 'gcauchon/vim-one' "Adaptation of one-light and one-dark colorschemes for Vim
Plug 'itchyny/lightline.vim' "Light and configurable statusline/tabline

Plug 'w0rp/ale' "ALE (Asynchronous Lint Engine) is a plugin for providing linting
Plug 'JakeBecker/elixir-ls' "Elixir Language Server

" Filetype-specific plugins
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
Plug 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
Plug 'slashmili/alchemist.vim', { 'for': ['elixir', 'eelixir'] }
Plug 'tpope/vim-endwise', { 'for': ['ruby', 'elixir'] }
Plug 'othree/html5.vim', { 'for': ['html', 'eruby', 'eelixir'] }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss'] }
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }
Plug 'ianks/vim-tsx', { 'for': ['typescript.tsx'] }
Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars'] }
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