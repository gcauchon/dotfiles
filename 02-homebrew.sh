!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew update

brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install zsh-autosuggestions
brew install tree

brew install git
brew install tig
brew install wget
brew install curl
brew install neovim/neovim/neovim # Vim-fork focused on extensibility and agility.
brew install ack # Search for PATTERN in each source file in the tree from the current directory on down.
brew install ripgrep # line oriented search tool that combines the usability of 'The Silver Searcher' (an ack fork) with the raw speed of GNU 'grep'.

brew install reattach-to-user-namespace
brew install tmux 

brew install gnupg2
brew install pgp-agent
# brew install keybase

# asdf
brew install asdf
asdf plugin-add nodejs
asdf plugin-add ruby
asdf plugin-add erlang
asdf plugin-add elixir

zsh /usr/local/opt/asdf/plugins/nodejs/bin/import-release-team-keyring

#
# Casks
#
brew install caskroom/cask/brew-cask

brew cask install alfred
brew cask install slate
#brew cask install spectacle
brew cask install iterm2
brew cask install dropbox
brew cask install google-drive-file-stream
brew cask install 1password
brew cask install cleanmymac
brew cask install istat-menus
brew cask install intel-power-gadget

brew cask install google-chrome
brew cask install firefox
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
