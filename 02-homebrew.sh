#!/bin/sh

mkdir ~/.config

# homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

# fish
brew install fish
sudo sh -c "echo '/usr/local/bin/fish' >> /etc/shells"

mkdir ~/.config/fish
ln -s $PWD/fish/config.fish ~/.config/fish/config.fish

chsh -s /usr/local/bin/fish

# fisherman
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

echo "-------------------------"
echo " fish + fisherman        "
echo "-------------------------"
echo " Install plugins found in the `fishfile`"
echo ""

# tmux
brew install reattach-to-user-namespace
brew install tmux
ln -s $PWD/tmux/.tmux.conf ~

# vim
brew install neovim/neovim/neovim # Vim-fork focused on extensibility and agility.
brew install ack # Search for PATTERN in each source file in the tree from the current directory on down.
brew install ripgrep # line oriented search tool that combines the usability of 'The Silver Searcher' (an ack fork) with the raw speed of GNU 'grep'.

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
ln -s $PWD/git/.gitconfig ~
ln -s $PWD/git/.gitignore_global ~

# Misc
brew install direnv
brew install tree
brew install wget
brew install curl
brew install tldr
brew install jq

# keybase
brew install gpg
brew install pgp-agent
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
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.3
asdf plugin-add nodejs
asdf plugin-add ruby
asdf plugin-add erlang
asdf plugin-add elixir

fish /usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring
brew install yarn --without-node

ln -s $PWD/ruby/.gemrc ~

# AWS
brew install awscli
brew install aws-elasticbeanstalk

# Heroku
brew install heroku

# crypto
# brew install parity
# rm -rf ~/Library/Application\ Support/io.parity.ethereum
# ln -s ~/Documents/parity ~/Library/Application\ Support/io.parity.ethereum

#
# Fonts
#
brew tap caskroom/fonts
brew cask install font-fira-code

#
# Casks
#
brew install caskroom/cask/brew-cask

brew cask install iterm2
brew cask install alfred
brew cask install dropbox
brew cask install 1password
brew cask install cleanmymac
brew cask install flux
brew cask install vanilla
brew cask install istat-menus
brew cask install intel-power-gadget

brew cask install docker
brew cask install google-chrome
brew cask install firefox
brew cask install atom
brew cask install dash
brew cask install quicklook-json

brew cask install harvest
brew cask install graphiql
brew cask install sketch
brew cask install tableplus
brew cask install transmit

brew cask install couleurs
brew cask install imageoptim
#brew cask install imagealpha
brew cask install zeplin

brew cask install slate
ln -s $PWD/slate/.slate.js ~

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
