#!/bin/sh 

# zsh
ln -s $(pwd)/zsh/.zsh ../.zsh
ln -s $(pwd)/zsh/.zshrc ../.zshrc

# add Homebrew ZSH to list of acceptable shells
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
# swith use shell to ZSH
chsh -s /usr/local/bin/zsh

# vim
ln -s $(pwd)/vim/.vim ../.vim
ln -s $(pwd)/vim/.vimrc ../.vimrc

# slate
ln -s $(pwd)/slate/.slate.js ../.slate.js

# ruby
ln -s $(pwd)/ruby/.gemrc ../.gemrc
