#!/bin/sh 

cd ~

# zsh
ln -s .dotfiles/zsh/.zsh
ln -s .dotfiles/zsh/.zshrc

# add Homebrew ZSH to list of acceptable shells
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
# swith use shell to ZSH
chsh -s /usr/local/bin/zsh

# vim
#ln -s .dotfiles/vim/.vim
#ln -s .dotfiles/vim/.vimrc
# neovim
mkdir .config
ln -s .dotfiles/vim/.vim .config/nvim

# tmux
ln -s .dotfiles/tmux/.tmux.conf

# git
ln -s .dotfiles/git/.gitconfig
ln -s .dotfiles/git/.gitignore_global

# ruby
ln -s .dotfiles/ruby/.gemrc

# slate
ln -s .dotfiles/slate/.slate.js

# keybase
keybase login
mkdir tmp
keybase pgp export -s > tmp/keybase-private.key
gpg --allow-secret-key-import --import tmp/keybase-private.key
keybase pgp export > tmp/keybase-public.key
gpg --import tmp/keybase-public.key
rm -rf tmp
