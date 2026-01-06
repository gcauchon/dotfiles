# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a macOS dotfiles repository for bootstrapping a new Mac with development tools and configurations. It manages symlinked configuration files for shell, editor, and various CLI tools.

## Setup Commands

```bash
# Run setup scripts sequentially (order matters)
./01-defaults.sh    # macOS system preferences
./02-homebrew.sh    # Install tools and create symlinks
```

## Architecture

### Symlink Structure
The repository uses symlinks from `~/.config/` and `~/` to files in this repo. Key mappings created by `02-homebrew.sh`:

- `zsh/.zshrc` → `~/.zshrc`
- `zsh/.zshenv` → `~/.zshenv`
- `zsh/sheldon.toml` → `~/.config/sheldon/plugins.toml`
- `zsh/starship.toml` → `~/.config/starship.toml`
- `zsh/tmux.conf` → `~/.config/tmux/tmux.conf`
- `neovim/` → `~/.config/nvim/`
- `git/.gitconfig` → `~/.gitconfig`
- `git/.gitignore_global` → `~/.gitignore_global`
- `ghostty/config` → `~/.config/ghostty/config`
- `gpg/` files → `~/.gnupg/`
- `mise/config.toml` → `~/.config/mise/config.toml`

### Neovim Configuration
- Uses lazy.nvim for plugin management
- Leader key: `,` (comma)
- Config structure: `neovim/lua/config/` (options, keymaps, autocmds) and `neovim/lua/plugins/` (plugin specs)
- Plugin lock file: `neovim/lazy-lock.json`

### ZSH Configuration
- Plugin manager: sheldon (`zsh/sheldon.toml`)
- Prompt: starship (`zsh/starship.toml`)
- Version manager: mise (`mise/config.toml`)
- Plugins: fzf, zoxide, zsh-syntax-highlighting, zsh-completions, zsh-autosuggestions

### Git Configuration
- Commit signing via 1Password SSH agent
- Default editor: nvim
- Diff pager: diff-so-fancy
