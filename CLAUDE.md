# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a macOS dotfiles repository for bootstrapping a new Mac with development tools and configurations. It manages symlinked configuration files for shell, editor, and various CLI tools.

## Setup Commands

```bash
# Run setup scripts sequentially (order matters)
./01-defaults.sh    # macOS system preferences
./02-homebrew.sh    # Homebrew + zsh symlinks + `brew bundle` from the Brewfile
./03-install.sh     # Non-brew steps: Claude installer, Touch ID for sudo (needs sudo, run it yourself)
./04-symlinks.sh    # Create config symlinks (idempotent, `ln -sfn`)
./05-cleanup.sh     # Post-install manual steps reminder
```

Packages live in the `Brewfile` (`brew bundle check`, `brew bundle cleanup`). Add new tools there, not as `brew install` lines in scripts.

## Architecture

### Symlink Structure

The repository uses symlinks from `~/.config/` and `~/` to files in this repo:

**ZSH** (created by `02-homebrew.sh`):

- `zsh/.zshrc` → `~/.zshrc`
- `zsh/.zshenv` → `~/.zshenv`
- `zsh/.zprofile` → `~/.zprofile` (`brew shellenv`, so it runs after macOS `path_helper` and reaches non-interactive login shells)

**Config files** (created by `04-symlinks.sh`):

- `zsh/sheldon.toml` → `~/.config/sheldon/plugins.toml`
- `zsh/starship.toml` → `~/.config/starship.toml`
- `zsh/tmux.conf` → `~/.config/tmux/tmux.conf`
- `zsh/ripgreprc` → `~/.config/ripgrep/ripgreprc`
- `neovim/` → `~/.config/nvim/`
- `git/.gitconfig` → `~/.gitconfig`
- `git/.gitignore_global` → `~/.gitignore_global`
- `git/.tigrc` → `~/.tigrc`
- `git/1password-agent.toml` → `~/.config/1Password/ssh/agent.toml`
- `ghostty/config` → `~/.config/ghostty/config`
- `mise/config.toml` → `~/.config/mise/config.toml`
- `ssh/config` → `~/.ssh/config`
- `docker/config.json` → `~/.docker/config.json` (uses `credsStore: osxkeychain`, keep it that way, or `docker login` writes tokens straight into this tracked file)
- `llms/claude/CLAUDE.md` → `~/.claude/CLAUDE.md` (user-level preferences)
- `llms/claude/settings.json` → `~/.claude/settings.json`
- `llms/claude/rules/` → `~/.claude/rules/` (language directives)
- `llms/claude/output-styles/` → `~/.claude/output-styles/` (response voice and formatting)
- `llms/claude/skills/` → `~/.claude/skills/` (user-level agent skills)
- `llms/claude/scripts/` → `~/.claude/scripts/` (status line, notification, and hook scripts)

### Neovim Configuration

- Uses lazy.nvim for plugin management
- Leader key: `,` (comma), local leader: `\`
- Config structure: `neovim/lua/config/` (options, keymaps, autocmds) and `neovim/lua/plugins/` (plugin specs)
- Plugin lock file: `neovim/lazy-lock.json`
- LSP uses Neovim 0.11+ API (`vim.lsp.config()` / `vim.lsp.enable()`) — not the older `lspconfig[server].setup()` pattern
- 12 LSP servers: lua_ls, elixirls, ruby_lsp, pyright, ts_ls, html, cssls, jsonls, yamlls, bashls, dockerls, marksman
- Fuzzy finder: mini.pick (not telescope). File explorer: mini.files. Surround/pairs/comment: mini.nvim suite
- Claude Code IDE integration: `coder/claudecode.nvim` (`neovim/lua/plugins/claudecode.lua`), native `:terminal` provider (no snacks.nvim), MCP-connected like the VS Code extension. Keymaps under `<leader>a`
- 2-space indentation, no swapfiles, system clipboard

### ZSH Configuration

- Plugin manager: sheldon (`zsh/sheldon.toml`)
- Prompt: starship (`zsh/starship.toml`)
- Version manager: mise (`mise/config.toml`) — Node.js 22.19.0, Ruby 3.4.6, Python 3.13.7, uv 0.8.17
- Plugins: fzf, zoxide, zsh-syntax-highlighting, zsh-completions, zsh-autosuggestions
- `.zshenv` sets `ERL_AFLAGS` for Erlang REPL shell history, `EDITOR`/`VISUAL` to nvim, `BUILDKIT_PROGRESS=tty` for Docker, and `RIPGREP_CONFIG_PATH`. Prompt-prone vars (`BUILDKIT_PROGRESS`, `GIT_TERMINAL_PROMPT`, `GIT_SSH_COMMAND`) are set only on a tty and explicitly unset otherwise, so Claude Code's Bash tool fails fast instead of hanging

### Terminal & Tmux

- Terminal: Ghostty with OneDark theme, FiraCode Nerd Font, size 14
- Tmux prefix: `Ctrl-Q` (remapped from default Ctrl-B)
- Vi mode keys in tmux; pane split: `=`/`-`, nav: `h/j/k/l`

### Git Configuration

- User: Guillaume Cauchon (`gcauchon@gmail.com`)
- Commit signing via 1Password SSH agent (`gpg.format = ssh` → `op-ssh-sign`)
- Default editor: nvim, diff pager: delta
- Default branch: `main`, pull with rebase
- Key aliases: `a` (add all), `c` (signed commit), `ca`/`cane` (amend with/without message), `s` (status), `d`/`ds` (diff/staged), `bd`/`bdf` (safe/force branch delete), `cb` (switch --create), `ph` (push HEAD), `pf` (force-with-lease + force-if-includes)

### Agent Skills

- `neovim-lua-config` — `.claude/skills/neovim-lua-config/` — Teaches AI agents Neovim Lua configuration conventions (plugin specs, LSP, keymaps, autocommands, anti-patterns). Includes `lua-patterns.md` with concrete code examples.

## Conventions

- **OneDark theme everywhere**: Ghostty, tmux, neovim, lightline — consistent dark theme
- **FiraCode Nerd Font** across terminal and editor
- **Scripts must run from repo root** — symlinks use `$PWD`-relative paths
- **Primary languages**: Elixir (with OTP), Ruby, Python, Node.js — all have LSP, treesitter, mise versions, and starship prompt sections
- **Docker via Colima** — not Docker Desktop
- **Pure shell + Homebrew** for provisioning — no Nix/Ansible
