#!/bin/sh

# zsh configuration
sudo apt install zsh curl git build-essential
chsh -s /bin/zsh

ln -s $PWD/zsh/.zshrc ~
ln -s $PWD/zsh/.zshenv ~

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# zsh configuration
ln -s "$PWD"/zsh/.zshrc ~
ln -s "$PWD"/zsh/.zshenv ~
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
brew update && brew upgrade && brew autoremove && brew cleanup

# zsh plugins
brew install sheldon
brew install fzf
brew install zoxide
brew install starship
