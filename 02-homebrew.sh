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

# keybase
brew install gnupg
brew install pinentry-mac

mkdir ~/.gnupg
ln -s $PWD/gpg/gpg.conf ~/.gnupg/gpg.conf
ln -s $PWD/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

brew cask install keybase

echo "-------------------------"
echo " Import PGP keys from Keybase "
echo "-------------------------"
echo " keybase login"
echo " mkdir tmp"
echo " keybase pgp export -s > tmp/keybase-private.key"
echo " gpg --allow-secret-key-import --import tmp/keybase-private.key"
echo " keybase pgp export > tmp/keybase-public.key"
echo " gpg --import tmp/keybase-public.key"
echo " rm -rf tmp"
echo ""

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.3
asdf plugin-add nodejs
asdf plugin-add ruby
asdf plugin-add erlang
asdf plugin-add elixir

bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

# Ruby
ln -s $PWD/ruby/.gemrc ~

# AWS
brew install awscli
brew install aws-elasticbeanstalk

# ETH
# brew install parity
# rm -rf ~/Library/Application\ Support/io.parity.ethereum
# ln -s ~/Documents/parity ~/Library/Application\ Support/io.parity.ethereum

#
# Fonts
#
brew tap homebrew/cask-fonts
brew cask install font-fira-code
brew cask install font-jetbrains-mono

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
brew cask install quicklook-json
brew cask install gifox

brew cask install sketch
brew cask install tableplus
brew cask install transmit

brew cask install couleurs
brew cask install imageoptim
brew cask install zeplin

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
