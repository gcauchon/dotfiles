#zsh
ln -s $(pwd)/zsh/.zsh ../.zsh
ln -s $(pwd)/zsh/.zshrc ../.zshrc

#vim
ln -s $(pwd)/vim/.vim ../.vim
ln -s $(pwd)/vim/.vimrc ../.vimrc
ln -s $(pwd)/vim/.gvimrc ../.gvimrc

# slate
rm ~/.slate
ln -s $(pwd)/slate/.slate.js ../.slate.js
