call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'sickill/vim-monokai'

call plug#end()

" Settings
source $HOME/.vim/config/settings.vim
source $HOME/.vim/config/plugins.vim
