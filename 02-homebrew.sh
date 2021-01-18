#!/bin/sh

mkdir ~/.config

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update

# fish
brew install fish
sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"

mkdir ~/.config/fish
ln -s $PWD/fish/config.fish ~/.config/fish/config.fish

chsh -s /usr/local/bin/fish

# fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

ln -s $PWD/fish/fishfile ~/.config/fish/fishfile
fisher

# starship
brew install starship
ln -s $PWD/fish/starship.toml ~/.config/starship.toml

# tmux
brew install reattach-to-user-namespace
brew install tmux
ln -s $PWD/tmux/.tmux.conf ~

# vim
brew install neovim
brew install ripgrep 

ln -s $PWD/vim ~/.config/nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "-------------------------"
echo " Remap Caps Lock to ESC "
echo "-------------------------"
echo " System Preferences… -> Keyboard -> Keyboard Tab -> Modifier Keys"
echo ""

# git
brew install git
brew install diff-so-fancy
brew install tig
ln -s $PWD/git/.gitconfig ~
ln -s $PWD/git/.gitignore_global ~
ln -s $PWD/git/.tigrc ~

# Misc
brew install direnv
brew install tree
brew install autoconf
brew install wget
brew install curl
brew install htop
brew install jq
brew install postgres
brew install mysql

# PGP
brew install gnupg
brew install pinentry-mac

mkdir ~/.gnupg
ln -s $PWD/gpg/gpg.conf ~/.gnupg/gpg.conf
ln -s $PWD/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add nodejs
asdf plugin-add ruby
asdf plugin-add python

bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

# Ruby
ln -s $PWD/ruby/.gemrc ~

# AWS
brew install awscli
brew install aws-elasticbeanstalk

#
# Fonts
#
brew tap homebrew/cask-fonts
brew cask install font-fira-code
brew cask install font-fira-code-nerd-font
brew cask install font-jetbrains-mono
brew cask install font-jetbrains-mono-nerd-font

#
# Casks
#
brew cask install iterm2
brew cask install alfred
brew cask install dropbox
brew cask install 1password
brew cask install flux

brew cask install docker
brew cask install google-chrome
brew cask install firefox
brew cask install dash
brew cask install gifox

brew cask install sketch
brew cask install tableplus

brew cask install pika # https://superhighfives.com/pika
brew cask install imageoptim

brew cask install slack
brew cask install spotify

echo "-------------------------"
echo " Post install notes! "
echo "-------------------------"
echo " Configure the following apps from their sync folder in Dropbox/Tools"
echo " - iTerm2"
echo " - Alfred"
echo " - Dash"
echo ""
