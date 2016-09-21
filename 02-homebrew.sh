#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update

brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install tree

brew install git
brew install wget
brew install curl
brew install vim --override-system-vi

brew install keybase

#brew install mysql
#brew install mongodb
#brew install redis

# asdf - extendable version manager
# https://github.com/asdf-vm/asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

asdf plugin-add ruby   https://github.com/asdf-vm/asdf-ruby
asdf install ruby 2.3.0
asdf plugin-add node   https://github.com/asdf-vm/asdf-nodejs
asdf install node 6.1.0
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
asdf install erlang 18.3
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
asdf install elixir 1.2.5

brew install caskroom/cask/brew-cask

brew cask install alfred
brew cask install spectacle
brew cask install iterm2
#
# iTerm2 key bindings to update...
#
#   	ACTION         	SEND
# ⌘ <-  "HEX CODE"      0x01
# ⌘ ->  "HEX CODE"      0x05
# ⌥ <-  "ESC SEQ"  	b
# ⌥ ->  "ESC SEQ"  	f
# DEL	"HEX CODE"	0x04
brew cask install dropbox
brew cask install onepassword
brew cask install cleanmymac

brew cask intall harvest

brew cask install google-chrome
brew cask install slack
brew cask install dash
#brew cask install ghostlab
brew cask install imageoptim
#brew cask install imagealpha

brew cask install spotify

