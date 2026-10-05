#!/bin/sh

mkdir -p ~/.config

# Sheldon ZSH plugin manager
mkdir -p ~/.config/sheldon
ln -sfn "$PWD"/zsh/sheldon.toml ~/.config/sheldon/plugins.toml

# SSH
mkdir -p ~/.ssh
ln -sfn "$PWD"/ssh/config ~/.ssh/config

# 1Password SSH agent
mkdir -p ~/.config/1Password/ssh
ln -sfn "$PWD"/git/1password-agent.toml ~/.config/1Password/ssh/agent.toml

# Starship prompt status line
ln -sfn "$PWD"/zsh/starship.toml ~/.config/starship.toml

# Ripgrep
mkdir -p ~/.config/ripgrep
ln -sfn "$PWD"/zsh/ripgreprc ~/.config/ripgrep/ripgreprc

# Ghostty
mkdir -p ~/.config/ghostty
ln -sfn "$PWD"/ghostty/config ~/.config/ghostty/config

# Tmux
mkdir -p ~/.config/tmux
ln -sfn "$PWD"/zsh/tmux.conf ~/.config/tmux/tmux.conf

# EditorConfig (global 2-space defaults, honored by Neovim 0.9+, VS Code, JetBrains, etc.)
ln -sfn "$PWD"/.editorconfig ~/.editorconfig

# Neovim
ln -sfn "$PWD"/neovim ~/.config/nvim

# git
ln -sfn "$PWD"/git/.gitconfig ~
ln -sfn "$PWD"/git/.gitignore_global ~
ln -sfn "$PWD"/git/.tigrc ~

# Mise-en-place
mkdir -p ~/.config/mise
ln -sfn "$PWD"/mise/config.toml ~/.config/mise/config.toml

# Docker (credsStore keeps `docker login` tokens in the macOS Keychain, not in this tracked file)
mkdir -p ~/.docker
ln -sfn "$PWD"/docker/config.json ~/.docker/config.json

# Claude
mkdir -p ~/.claude
ln -sfn "$PWD"/llms/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sfn "$PWD"/llms/claude/settings.json ~/.claude/settings.json
ln -sfn "$PWD"/llms/claude/output-styles ~/.claude/output-styles
ln -sfn "$PWD"/llms/claude/skills ~/.claude/skills
ln -sfn "$PWD"/llms/claude/rules ~/.claude/rules
ln -sfn "$PWD"/llms/claude/scripts ~/.claude/scripts
