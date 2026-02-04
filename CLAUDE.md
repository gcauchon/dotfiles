# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a macOS dotfiles repository for bootstrapping a new Mac with development tools and configurations. It manages symlinked configuration files for shell, editor, and various CLI tools.

## Setup Commands

```bash
# Run setup scripts sequentially (order matters)
./01-defaults.sh    # macOS system preferences
./02-homebrew.sh    # Homebrew + zsh symlinks + shell plugins (sheldon, fzf, zoxide, starship)
./03-install.sh     # Terminal/dev tools (ghostty, tmux, neovim, mise, git tools)
./04-symlinks.sh    # Create config symlinks
./05-cleanup.sh     # Post-install manual steps reminder
```

## Architecture

### Symlink Structure

The repository uses symlinks from `~/.config/` and `~/` to files in this repo:

**ZSH** (created by `02-homebrew.sh`):

- `zsh/.zshrc` → `~/.zshrc`
- `zsh/.zshenv` → `~/.zshenv`

**Config files** (created by `04-symlinks.sh`):

- `zsh/sheldon.toml` → `~/.config/sheldon/plugins.toml`
- `zsh/starship.toml` → `~/.config/starship.toml`
- `zsh/tmux.conf` → `~/.config/tmux/tmux.conf`
- `neovim/` → `~/.config/nvim/`
- `git/.gitconfig` → `~/.gitconfig`
- `git/.gitignore_global` → `~/.gitignore_global`
- `git/.tigrc` → `~/.tigrc`
- `git/1password-agent.toml` → `~/.config/1Password/ssh/agent.toml`
- `ghostty/config` → `~/.config/ghostty/config`
- `mise/config.toml` → `~/.config/mise/config.toml`
- `llms/claude/settings.json` → `~/.claude/settings.json`
- `llms/claude/settings/statusline.sh` → `~/.claude/settings/statusline.sh`

### Neovim Configuration

- Uses lazy.nvim for plugin management
- Leader key: `,` (comma)
- Config structure: `neovim/lua/config/` (options, keymaps, autocmds) and `neovim/lua/plugins/` (plugin specs)
- Plugin lock file: `neovim/lazy-lock.json`

### ZSH Configuration

- Plugin manager: sheldon (`zsh/sheldon.toml`)
- Prompt: starship (`zsh/starship.toml`)
- Version manager: mise (`mise/config.toml`) - Node.js 22, Ruby 3.4, Python 3.13
- Plugins: fzf, zoxide, zsh-syntax-highlighting, zsh-completions, zsh-autosuggestions

### Terminal & Tmux

- Terminal: Ghostty with OneDark theme, FiraCode Nerd Font
- Tmux prefix: `Ctrl-Q` (remapped from default Ctrl-B)

### Git Configuration

- Commit signing via 1Password SSH agent
- Default editor: nvim
- Diff pager: diff-so-fancy
