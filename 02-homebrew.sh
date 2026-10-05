#!/bin/sh

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update

# zsh configuration (.zprofile carries `brew shellenv` so non-interactive login shells get it too)
ln -sfn "$PWD"/zsh/.zshrc ~
ln -sfn "$PWD"/zsh/.zshenv ~
ln -sfn "$PWD"/zsh/.zprofile ~

# packages: zsh plugins, terminal, neovim, git, dev tools, apps, fonts
brew bundle --file="$PWD"/Brewfile
