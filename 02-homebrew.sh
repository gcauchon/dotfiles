#!/bin/sh 
 
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install zsh
brew install git
brew install wget
brew install rbenv
brew install ruby-build

brew install caskroom/cask/brew-cask

brew cask install alfred
brew cask install slate
brew cask install dropbox 
brew cask install onepassword
brew cask install evernote
brew cask install cleanmymac
brew cask install macpaw-gemini

#
# key bindings to update...
#
#   	ACTION         	SEND
# ⌘ <-  "HEX CODE"      0x01 
# ⌘ ->  "HEX CODE"      0x05
# ⌥ <-  "ESC SEQ"  	b
# ⌥ ->  "ESC SEQ"  	f
# DEL	"HEX CODE"	0x04 

brew cask install iterm2
brew cask install google-chrome
brew cask install google-hangouts
brew cask install sublime-text
brew cask install sequel-pro
brew cask install dash
brew cask install rdio
brew cask install sketchup
brew cask install imageoptim
brew cask install imagealpha
brew cask install adobe-creative-cloud
