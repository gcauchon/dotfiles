!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update

# ZSH
brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions

# add Homebrew ZSH to list of acceptable shells
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
# swith use shell to ZSH
chsh -s /usr/local/bin/zsh

ln -s zsh/.zsh ~/.zsh
ln -s zsh/.zshrc ~/.zshrc

# git
brew install git
brew install tig
ln -s git/.gitconfig ~/.gitconfig
ln -s git/.gitignore_global ~/.gitignore_global

# tmux
brew install reattach-to-user-namespace
brew install tmux
ln -s tmux/.tmux.conf ~/.tmux.conf

# vim
brew install neovim/neovim/neovim # Vim-fork focused on extensibility and agility.
brew install ack # Search for PATTERN in each source file in the tree from the current directory on down.
brew install ripgrep # line oriented search tool that combines the usability of 'The Silver Searcher' (an ack fork) with the raw speed of GNU 'grep'.

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir ~/.config
ln -s vim ~/.config/nvim

# Misc
brew install tree
brew install wget
brew install curl
brew install tldr
brew install jq

# keybase
# brew install gnupg2
# brew install pgp-agent
# brew install keybase
# keybase login
# mkdir tmp
# keybase pgp export -s > tmp/keybase-private.key
# gpg --allow-secret-key-import --import tmp/keybase-private.key
# keybase pgp export > tmp/keybase-public.key
# gpg --import tmp/keybase-public.key
# rm -rf tmp

# asdf
brew install asdf
asdf plugin-add nodejs
asdf plugin-add ruby
asdf plugin-add erlang
asdf plugin-add elixir

zsh /usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring
brew install yarn --without-node

ln -s ruby/.gemrc ~/.gemrc

# nv
brew tap jcouture/nv
brew install nv

# AWS
brew install aws-cli
brew install aws-elasticbeanstalk

# Heroku
brew install heroku

# crypto
brew install parity
rm -rf ~/Library/Application\ Support/io.parity.ethereum
ln -s ~/Documents/parity ~/Library/Application\ Support/io.parity.ethereum

#
# Casks
#
brew install caskroom/cask/brew-cask

brew cask install iterm2
brew cask install alfred
brew cask install dropbox
brew cask install 1password
brew cask install cleanmymac
brew cask install vanilla
brew cask install istat-menus
brew cask install intel-power-gadget

brew cask install docker
brew cask install google-chrome
brew cask install firefox
brew cask install atom
brew cask install dash

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
ln -s slate/.slate.js ~/.slate.js

brew cask install slack
brew cask install spotify

echo ""
echo " Post install notes..."
echo "-------------------------"
echo " Configure the profile for the following tools from Dropbox /Tools:"
echo " - iTerm2"
echo " - Alfred"
echo " - Dash"
echo ""
