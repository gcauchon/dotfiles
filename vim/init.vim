call plug#begin('~/.config/nvim/plugged')

" A dark Vim/Neovim color scheme inspired by Atom's One Dark syntax theme
" Plug 'joshdick/onedark.vim'
" A Vim port of the monokai theme for TextMate
Plug 'tomasr/molokai'

" Light and configurable statusline/tabline
Plug 'itchyny/lightline.vim'

" A general-purpose command-line fuzzy finder.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Helps you win at grep
Plug 'mhinz/vim-grepper'

" Find/Replace from the Quickfix window
Plug 'stefandtw/quickfix-reflector.vim'

" Language packs
Plug 'elixir-editors/vim-elixir'

" Navigate thru CamelCase or snake_case (ie: w, e, b)
Plug 'vim-scripts/camelcasemotion'

" Quoting/Parenthesizing made simple
Plug 'tpope/vim-surround'

" Place, toggle and display marks
Plug 'kshenoy/vim-signature'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Shows git diff in the gutter and stages/undoes hunks
Plug 'airblade/vim-gitgutter'

" Intellisense engine for vim8 & neovim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/mappings.vim
source ~/.config/nvim/config/filetype.vim
source ~/.config/nvim/config/plugins.vim
