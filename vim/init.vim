call plug#begin('~/.config/nvim/plugged')

Plug 'gcauchon/vim-one'         " Adaptation of one-light and one-dark colorschemes for Vim
Plug 'itchyny/lightline.vim'    " Light and configurable statusline/tabline

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " A command-line fuzzy finder
Plug 'junegunn/fzf.vim'         " fzf <3 vim
Plug 'yegappan/mru'             " Most Recently Used (MRU) plugin
Plug 'vim-scripts/camelcasemotion' " Navigate thru CamelCase or snake_case (ie: w, e, b)

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense engine for vim8 & neovim
Plug 'sheerun/vim-polyglot'     " A solid language pack for Vim.
Plug 'mhinz/vim-grepper'        " Helps you win at grep
Plug 'tpope/vim-surround'       " Quoting/Parenthesizing made simple
Plug 'tpope/vim-fugitive'       " A Git wrapper so awesome, it should be illegal
Plug 'airblade/vim-gitgutter'   " Shows git diff in the gutter and stages/undoes hunks

call plug#end()

source ~/.config/nvim/config/settings.vim
source ~/.config/nvim/config/mappings.vim
source ~/.config/nvim/config/filetype.vim
source ~/.config/nvim/config/plugins.vim
