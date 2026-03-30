# Why?

Setup a clean or new Mac in a breeze with almost every tools I use daily.

# How?

1. Clone repo to your `$HOME` directory

```shell
> git clone https://github.com/gcauchon/dotfiles.git .dotfiles
Cloning into '.dotfiles'...
remote: Enumerating objects: 18, done.
remote: Counting objects: 100% (18/18), done.
remote: Compressing objects: 100% (16/16), done.
remote: Total 982 (delta 2), reused 8 (delta 1), pack-reused 964
Receiving objects: 100% (982/982), 232.10 KiB | 2.64 MiB/s, done.
Resolving deltas: 100% (462/462), done.
> cd .dotfiles
```

2. Review and customize the setup scripts as needed.

3. Run each script sequentially:

```shell
> ./01-defaults.sh    # macOS system preferences
> ./02-homebrew.sh    # Homebrew + zsh symlinks + shell plugins
> ./03-install.sh     # Terminal/dev tools installation
> ./04-symlinks.sh    # Create config symlinks for all tools
> ./05-cleanup.sh     # Post-install manual reminders
```

# What's Included?

## Core Tools (02-homebrew.sh)

- `homebrew` - https://brew.sh
- `zsh` - Built-in macOS zsh shell with symlinked config
- `sheldon` - ZSH plugin manager
- `fzf` - Fuzzy finder
- `zoxide` - Smarter cd command
- `starship` - https://starship.rs - Cross-shell prompt

## Development Tools (03-install.sh)

- `ghostty` - https://ghostty.org - Modern terminal emulator
- `tmux` - https://github.com/tmux/tmux/wiki
- `neovim` - https://neovim.io (with `lua`, `luarocks`, `fd`, `ripgrep`)
- `git` - with `tig`, `diff-so-fancy`
- `mise` - https://mise.jdx.dev - Runtime version manager
- `docker` & `colima` - https://github.com/abiosoft/colima
- Additional CLI tools: `autoconf`, `curl`, `jq`, `ngrok`
- `fonts` - `Fira Code` with `Nerd Font` patched glyphs

## Applications (03-install.sh)

- Alfred - https://www.alfredapp.com
- 1Password - https://1password.com (with CLI for SSH agent & commit signing)
- Firefox & Google Chrome browsers
- Visual Studio Code - https://code.visualstudio.com
- Dash - https://kapeli.com/dash
- TablePlus - https://tableplus.com
- Utility apps: LanguageTool, Lunar, Pika

## Config Symlinks (04-symlinks.sh)

All configuration files are symlinked from this repo:

- ZSH: sheldon plugins, starship prompt
- Terminal: ghostty, tmux
- Editor: neovim (full lua config), VS Code settings via extensions
- Git: gitconfig, gitignore, tigrc
- 1Password SSH agent config (for commit signing)
- mise runtime versions
- Claude Code settings & statusline

## Claude Configuration (llms/claude/)

Configuration for both [Claude.ai](https://claude.ai) and [Claude Code](https://claude.ai/code), symlinked to `~/.claude/` by `04-symlinks.sh`.

| File | Symlink Target | Purpose |
|------|---------------|---------|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | User-level preferences (code style, stack, git conventions) |
| `settings.json` | `~/.claude/settings.json` | Claude Code settings (permissions, hooks, model, status line) |
| `rules/` | `~/.claude/rules/` | Response style, language, tone directives |
| `scripts/` | `~/.claude/scripts/` | Custom status line and API usage tracking |

**Dual-purpose files**: `CLAUDE.md` and `rules/conversation-style.md` are loaded by Claude Code as project/global instructions. Their content must also be copied manually to Claude.ai under **Settings > User Preferences** to maintain consistent behavior across both interfaces.

Agent skills live in `.claude/skills/` (e.g., `neovim-lua-config` for Neovim Lua patterns).

### You are in business! 🚀
