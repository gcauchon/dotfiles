#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install tree

brew install git
brew install wget
brew install vim --override-system-vi
brew install rbenv
brew install ruby-build

rbenv install 2.3.0

brew install mysql
brew install mongodb
brew install redis
brew isntall node

brew install caskroom/cask/brew-cask

brew cask install alfred
brew cask install slate
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

brew cask install google-chrome
brew cask install slack
brew cask install dash
#brew cask install sequel-pro
#brew cask install ghostlab
brew cask install imageoptim
#brew cask install imagealpha

#brew cask install boom
brew cask install spotify
