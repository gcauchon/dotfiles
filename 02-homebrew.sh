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
mkdir --parents ~/.config/sheldon
ln -s $PWD/sheldon/plugins.toml ~/.config/sheldon/plugins.toml

# starship
brew install starship
ln -s $PWD/zsh/starship.toml ~/.config/starship.toml

# tmux
brew install tmux
ln -s $PWD/tmux/.tmux.conf ~

# neovim
brew install neovim
brew install lua
brew install luarocks
brew install fd
brew install ripgrep

ln -s $PWD/neovim ~/.config/neovim

# ⮑ lua package management
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# git
brew install git
brew install tig
brew install diff-so-fancy
ln -s $PWD/git/.gitconfig ~
ln -s $PWD/git/.gitignore_global ~
ln -s $PWD/git/.tigrc ~

# Misc
brew install autoconf
brew install curl
brew install jq
brew install ngrok

# PGP
brew install gnupg
brew install pinentry-mac

mkdir ~/.gnupg
ln -s $PWD/gpg/gpg.conf ~/.gnupg/gpg.conf
ln -s $PWD/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# mise
brew install mise
# vvv Already in zsh config file vvv
# echo 'mise activate zsh | source' >> ~/.zshrc
ln -s $PWD/mise/config.toml ~/.config/mise/config.toml

# docker
brew install docker
brew install colima

#
# Fonts
#
brew install font-fira-code font-fira-code-nerd-font

#
# Casks
#
brew install alfred
brew install 1password
brew install 1password-cli
brew install firefox
brew install google-chrome

brew install ghostthy
ln -s $PWD/ghostty/config ~/.config/ghostty/config

brew install visual-studio-code
brew install dash
brew install tableplus
#brew install postman

brew install caffeine
brew install imageoptim
brew install gifox
brew install languagetool
brew install lunar
brew install pika # https://superhighfives.com/pika
brew install slack
brew install spotify

echo "====================="
echo " Post install notes! "
echo "====================="

echo ""
echo " Remap Caps Lock to ESC:"
echo "-------------------------"
echo " System Preferences -> Keyboard -> Keyboard Tab -> Modifier Keys"
echo ""

echo " Disable 'Shake mouse pointer to locate':"
echo "------------------------------------------"
echo " System Preferences -> Accessibility -> Display -> Cursor"
echo ""

echo " Configure sync in iCloud/Documents/Tools:"
echo "-------------------------------------------"
echo " - Alfred"
echo " - Dash"
echo ""
