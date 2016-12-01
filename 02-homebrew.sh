!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update

brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install tree

brew install git
brew install tig
brew install wget
brew install curl
#brew install vim --override-system-vi
brew install neovim/neovim/neovim

brew install reattach-to-user-namespace
brew install tmux

brew install gnupg2
brew install pgp-agent

# keybase
brew install keybase

# asdf - extendable version manager
# https://github.com/asdf-vm/asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

asdf plugin-add ruby   https://github.com/asdf-vm/asdf-ruby
asdf install ruby 2.3.3
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang
#asdf install erlang 18.3
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir
#asdf install elixir 1.2.5

# A better npm packager!
brew install yarn

brew install caskroom/cask/brew-cask

brew cask install alfred
brew cask install slate
#brew cask install spectacle
brew cask install iterm2
brew cask install dropbox
brew cask install sync
brew cask install 1password
brew cask install cleanmymac

brew cask install google-chrome
brew cask install atom
brew cask install slack
brew cask install dash
#brew cask install ghostlab
brew cask install imageoptim
#brew cask install imagealpha

brew cask install spotify

echo "========================="
echo " Installation completed!"
echo "-------------------------"
echo " Post-install notes:"
echo ""
echo " The profile for the following tools are saved to Dropbox:"
echo " - iTerm2"
echo " - Alfred"
echo "========================="
