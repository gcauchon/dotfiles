#!/bin/sh

mkdir -p ~/.config

# Sheldon ZSH plugin manager
mkdir -p ~/.config/sheldon
ln -s $PWD/zsh/sheldon.toml ~/.config/sheldon/plugins.toml

# Starship prompt status line
ln -s $PWD/zsh/starship.toml ~/.config/starship.toml

# Ghostty
mkdir -p ~/.config/ghostty
ln -s $PWD/ghostty/config ~/.config/ghostty/config

# Tmux
mkdir -p ~/.config/tmux
ln -s $PWD/zsh/tmux.conf ~/.config/tmux/tmux.conf

# Neovim
ln -s $PWD/neovim ~/.config/nvim

# git
ln -s $PWD/git/.gitconfig ~
ln -s $PWD/git/.gitignore_global ~
ln -s $PWD/git/.tigrc ~

# Mise-en-place
mkdir -p ~/.config/mise
ln -s $PWD/mise/config.toml ~/.config/mise/config.toml

# 1Password SSH agent
mkdir -p ~/.config/1Password/ssh
ln -s $PWD/git/1password-agent.toml ~/.config/1Password/ssh/agent.toml

# Claude
mkdir -p ~/.claude/settings
ln -s $PWD/llms/claude/settings.json ~/.claude/settings.json
ln -s $PWD/llms/claude/statusline.sh ~/.claude/statusline.sh