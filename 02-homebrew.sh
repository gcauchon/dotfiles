#!/bin/sh

# homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/gcauchon/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew update

# fish
brew install fish
sudo sh -c "echo '/opt/homebrew/bin/fish' >> /etc/shells"

mkdir -p ~/.config/fish
ln -s $PWD/fish/config.fish ~/.config/fish/config.fish

chsh -s /opt/homebrew/bin/fish

# fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

ln -s $PWD/fish/fishfile ~/.config/fish/fishfile
#fisher

# starship
brew install starship
ln -s $PWD/fish/starship.toml ~/.config/starship.toml

# tmux
brew install tmux
ln -s $PWD/tmux/.tmux.conf ~

# neovim
brew install neovim
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
brew install direnv
brew install autoconf
brew install wget
brew install curl
brew install jq
brew install ngrok
#brew install postgres
#brew install mysql
#brew install terraform

# PGP
brew install gnupg
brew install pinentry-mac

mkdir ~/.gnupg
ln -s $PWD/gpg/gpg.conf ~/.gnupg/gpg.conf
ln -s $PWD/gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf

# asdf
brew install coreutils
brew install wxmac
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0
mkdir -p ~/.config/fish/completions
cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions

# Ruby
ln -s $PWD/ruby/.gemrc ~

# AWS
brew install awscli

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
brew install alfred
brew install 1password
brew install dash
#brew install harvest
brew install google-chrome
brew install firefox

# Native tools for Google Mail and Calendar
brew install mimestream
brew install fantastical

brew install iterm2
brew install visual-studio-code
brew install tableplus
#brew install postman


brew install slack
brew install signal

brew install gifox
#brew install sketch
brew install pika # https://superhighfives.com/pika
brew install imageoptim

brew install spotify

echo "====================="
echo " Post install notes! "
echo "====================="
echo ""
echo " Remap Caps Lock to ESC:"
echo "------------------------"
echo " System Preferences -> Keyboard -> Keyboard Tab -> Modifier Keys"
echo ""
echo " Disable 'Shake mouse pointer to locate':"
echo "-----------------------------------------"
echo " System Preferences -> Accessibility -> Display -> Cursor"
echo ""

echo " Configure sync in iCloud/Documents/Tools:"
echo "------------------------------------------"
echo " - iTerm2"
echo " - Alfred"
echo " - Dash"
echo ""

echo " asdf-vm:"
echo "---------"
echo "> asdf plugin-add erlang"
echo "> asdf plugin-add elixir"
echo "> asdf plugin-add nodejs"
echo "> bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring"
echo "> asdf plugin-add ruby"
echo ""
