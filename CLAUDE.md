# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a macOS dotfiles repository for bootstrapping a new Mac with development tools and configurations. It manages symlinked configuration files for shell, editor, and various CLI tools.

## Setup Commands

```bash
# Run setup scripts sequentially (order matters)
./01-defaults.sh    # macOS system preferences
./02-homebrew.sh    # Homebrew + zsh symlinks + chsh to zsh + shell plugins (sheldon, fzf, zoxide, starship)
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
- `ghostty/config` → `~/.config/ghostty/config`
- `mise/config.toml` → `~/.config/mise/config.toml`
- `ssh/config` → `~/.ssh/config`
- `docker/config.json` → `~/.docker/config.json` (uses `credsStore: pass` — keep it that way, or `docker login` writes tokens straight into this tracked file)
- `gnupg/gpg-agent.conf` → `~/.gnupg/gpg-agent.conf` (routes pinentry through `gnupg/pinentry-wrapper`, keeping GPG passphrase prompts out of any terminal Claude Code holds)
- `llms/claude/CLAUDE.md` → `~/.claude/CLAUDE.md` (user-level preferences)
- `llms/claude/settings.json` → `~/.claude/settings.json` (`CLAUDE_CODE_ENABLE_TODO_TOOLS=1` in its `env` restores the todo/task tools, which Claude Code 2.1.233 gated off for Opus 4.8 / Sonnet 5 and newer — re-check on upgrades, since the escape hatch may go away; plan files under `.claude/plans` are the idiomatic upfront-plan mechanism regardless)
- `llms/claude/rules/` → `~/.claude/rules/` (language, markdown, PR-comment voice directives)
- `llms/claude/output-styles/` → `~/.claude/output-styles/` (response voice and formatting)
- `llms/claude/skills/` → `~/.claude/skills/` (user-level agent skills; `skills/synced/` is written there by claude.ai skill sync and is gitignored)
- `llms/claude/scripts/` → `~/.claude/scripts/` (statusline)

Because these are symlinks into the repo, Claude Code writes into tracked files: `/model` and `/config` toggles land in `settings.json`, and `gh auth setup-git` appends to `git/.gitconfig`. Review such diffs before committing rather than treating them as noise.

### Neovim Configuration

- Uses lazy.nvim for plugin management
- Leader key: `,` (comma), local leader: `\`
- Config structure: `neovim/lua/config/` (options, keymaps, autocmds) and `neovim/lua/plugins/` (plugin specs)
- Plugin lock file: `neovim/lazy-lock.json`
- LSP uses Neovim 0.11+ API (`vim.lsp.config()` / `vim.lsp.enable()`) — not the older `lspconfig[server].setup()` pattern
- 12 LSP servers: lua_ls, elixirls, ruby_lsp, pyright, ts_ls, html, cssls, jsonls, yamlls, bashls, dockerls, marksman
- Fuzzy finder: mini.pick (not telescope). File explorer: mini.files. Surround/pairs/comment: mini.nvim suite
- 2-space indentation, no swapfiles, system clipboard

### ZSH Configuration

- Plugin manager: sheldon (`zsh/sheldon.toml`)
- Prompt: starship (`zsh/starship.toml`)
- Version manager: mise (`mise/config.toml`) — Node.js 22.19.0, Ruby 3.4.6, Python 3.13.7, uv 0.8.17
- Plugins: fzf, zoxide, zsh-syntax-highlighting, zsh-completions, zsh-autosuggestions
- `.zshenv` sets `ERL_AFLAGS` for Erlang REPL shell history, `BUILDKIT_PROGRESS=tty` and `DOCKER_DEFAULT_PLATFORM=linux/amd64` for Docker

### Terminal & Tmux

- Terminal: Ghostty with OneDark theme, FiraCode Nerd Font, size 14
- Tmux prefix: `Ctrl-Q` (remapped from default Ctrl-B)
- Vi mode keys in tmux; pane split: `=`/`-`, nav: `h/j/k/l`
- Seamless Neovim/tmux navigation without the prefix: `Ctrl-h/j/k/l` moves, `Alt-h/j/k/l` resizes (smart-splits.nvim in `neovim/lua/plugins/editor.lua` + matching `bind -n` lines in `zsh/tmux.conf`). Inside tmux, use `clear` instead of `Ctrl-L`
- Copy mode yanks to the system clipboard over OSC 52 (`set-clipboard on`), no `pbcopy` dependency

### Git Configuration

- User: Guillaume Cauchon (`gcauchon@gmail.com`)
- Commit signing via `gpg.format = ssh` — git calls `ssh-keygen -Y sign` against the keychain-loaded SSH agent, no `op-ssh-sign` program configured
- Default editor: nvim, diff pager: diff-so-fancy
- Default branch: `main`, pull with rebase
- Key aliases: `a` (add all), `c` (signed commit), `ca`/`cane` (amend with/without message), `s` (status), `d`/`ds` (diff/staged), `bd`/`bdf` (safe/force branch delete), `ph` (push HEAD), `pf` (force-with-lease + force-if-includes)

### Agent Skills

- `neovim-lua-config` — `.claude/skills/neovim-lua-config/` — Teaches AI agents Neovim Lua configuration conventions (plugin specs, LSP, keymaps, autocommands, anti-patterns). Includes `lua-patterns.md` with concrete code examples.

## Conventions

- **OneDark theme everywhere**: Ghostty, tmux, neovim, lightline — consistent dark theme
- **FiraCode Nerd Font** across terminal and editor
- **Scripts must run from repo root** — symlinks use `$PWD`-relative paths
- **Primary languages**: Elixir (with OTP), Ruby, Python, Node.js — all have LSP, treesitter, mise versions, and starship prompt sections
- **Docker via Colima** — not Docker Desktop
- **Pure shell + Homebrew** for provisioning — no Nix/Ansible
