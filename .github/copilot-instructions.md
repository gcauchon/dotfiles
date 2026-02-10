# Copilot Instructions

## Repository Purpose

macOS dotfiles repo — bootstraps a new Mac with symlinked configs for shell, editor, and CLI tools.

## Setup

Scripts run sequentially from repo root (order matters):

```bash
./01-defaults.sh    # macOS system preferences
./02-homebrew.sh    # Homebrew + zsh symlinks + shell plugins
./03-install.sh     # Terminal/dev tools (ghostty, tmux, neovim, mise)
./04-symlinks.sh    # Create config symlinks
./05-cleanup.sh     # Post-install manual steps
```

## Key Patterns

- **Symlinks use `$PWD`-relative paths** — scripts must run from repo root
- **Pure shell + Homebrew** for provisioning — no Nix/Ansible
- **OneDark theme** everywhere: Ghostty, tmux, neovim
- **FiraCode Nerd Font** across terminal and editor

## Neovim (0.11+)

- Plugin manager: lazy.nvim (`neovim/lua/plugins/`)
- Config: `neovim/lua/config/` (options, keymaps, autocmds)
- LSP: use `vim.lsp.config()` / `vim.lsp.enable()` — NOT `lspconfig[server].setup()`
- Primary suite: mini.nvim (mini.pick, mini.files, mini.surround, mini.pairs, mini.comment)
- Leader: `,` — Local leader: `\`
- 2-space indent, no swapfiles, system clipboard

## Shell

- ZSH with sheldon (plugin manager), starship (prompt), fzf, zoxide
- Versions via mise: Node.js 22.19.0, Ruby 3.4.6, Python 3.13.7, uv 0.8.17
- Primary languages: Elixir/OTP, Ruby, Python, Node.js

## Tmux

- Prefix: `Ctrl-Q`
- Vi mode keys; splits: `=`/`-`, nav: `h/j/k/l`

## Git

- Commit signing via 1Password SSH agent
- Default branch: `main`, pull with rebase
- Diff pager: diff-so-fancy

## Conventions

- When adding a new config, add the symlink in `04-symlinks.sh` and document it in `CLAUDE.md`
- When adding a neovim plugin, create a new file in `neovim/lua/plugins/`
- When adding a shell plugin, add it to `zsh/sheldon.toml`
- Docker via Colima — not Docker Desktop
