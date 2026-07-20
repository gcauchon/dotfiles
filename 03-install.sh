#!/bin/sh

# Terminal
brew install ghostty
brew install tmux
brew install terminal-notifier

# neovim
brew install neovim
brew install tree-sitter-cli # CLI for nvim-treesitter main-branch parser builds
brew install lua
brew install luarocks
brew install fd
brew install ripgrep

# git
brew install git
brew install tig
brew install git-delta

# AI
curl -fsSL https://claude.ai/install.sh | sh
# brew install claude-code -- the release cycle is slow, so we install the latest version directly from the Claude team

# Web browsers
brew install firefox
brew install google-chrome

# Development tools
brew install autoconf
brew install curl
brew install mise
brew install visual-studio-code
#brew install dash
#brew install tableplus
#brew install postman
brew install docker
brew install colima
brew install jq
brew install dprint
brew install ngrok

# Modern CLI replacements
brew install eza              # Better ls (replaces ls -oah)
brew install bat              # Better cat (syntax highlighting)

# Utilities
brew install alfred
brew install 1password
brew install 1password-cli
#brew install imageoptim
#brew install gifox
brew install lunar
brew install pika
#brew install slack
#brew install spotify

# Fonts
brew install font-fira-code font-fira-code-nerd-font
