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
brew cask install iterm2
brew cask install google-chrome
brew cask install google-hangouts
brew cask install sublime-text
brew cask install sequel-pro
brew cask install dash
brew cask install adode-creative-cloud