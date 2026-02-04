#!/bin/sh

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update

# zsh configuration
ln -s $PWD/zsh/.zshrc ~
ln -s $PWD/zsh/.zshenv ~

# zsh plugins
brew install sheldon
brew install fzf
brew install zoxide
brew install starship
