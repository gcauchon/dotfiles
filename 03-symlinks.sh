#!/bin/sh 

cd ~

# zsh
ln -s .dot-files/zsh/.zsh
ln -s .dot-files/zsh/.zshrc

# add Homebrew ZSH to list of acceptable shells
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
# swith use shell to ZSH
chsh -s /usr/local/bin/zsh

# vim
ln -s .dot-files/vim/.vim
ln -s .dot-files/vim/.vimrc

# tmux
ln -s .dot-files/tmux/.tmux.conf

# git
ln -s .dot-files/tmux/.gitconfig
ln -s .dot-files/tmux/.gitignore_global

# ruby
ln -s .dot-files/ruby/.gemrc
