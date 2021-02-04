#!/bin/sh

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew update

# fish
brew install fish
sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"

mkdir -p ~/.config/fish
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
brew install tig
brew install diff-so-fancy
ln -s $PWD/git/.gitconfig ~
ln -s $PWD/git/.gitignore_global ~
ln -s $PWD/git/.tigrc ~

# Misc
brew install direnv
brew install autoconf
brew install wget
brew install curl
brew install jq
brew install ngrok
brew install postgres
brew install mysql

# PGP
brew install gnupg
brew install pinentry-mac

mkdir ~/.gnupg
ln -s $PWD/gpg/gpg.conf ~/.gnupg/gpg.conf
ln -s $PWD/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# asdf
brew install coreutils
git clone git@github.com:asdf-vm/asdf.git ~/.asdf --branch v0.8.0
mkdir -p ~/.config/fish/completions; and cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions

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
brew install font-fira-code
brew install font-fira-code-nerd-font
brew install font-jetbrains-mono
brew install font-jetbrains-mono-nerd-font

#
# Casks
#
brew install --cask alfred
brew install --cask 1password
brew install --cask dash
brew install --cask dropbox
brew install --cask harvest
brew install --cask google-chrome
brew install --cask firefox

brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask docker
brew install --cask tableplus
brew install --cask postman

brew install --cask slack
brew install --cask signal
brew install --cask microsoft-teams

brew install --cask gifox
brew install --cask sketch
brew install --cask pika # https://superhighfives.com/pika
brew install --cask imageoptim

brew install --cask spotify

echo "-------------------------"
echo " Post install notes! "
echo "-------------------------"
echo " Configure the following apps from their sync folder in Dropbox/Tools"
echo " - iTerm2"
echo " - Alfred"
echo " - Dash"
echo ""
