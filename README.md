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
> ./02-homebrew.sh    # Homebrew + zsh symlinks + `brew bundle` (Brewfile)
> ./03-install.sh     # Claude installer + Touch ID for sudo (asks for your password)
> ./04-symlinks.sh    # Create config symlinks for all tools (safe to re-run)
> ./05-cleanup.sh     # Post-install manual reminders
```

Packages are declared in the `Brewfile`. Use `brew bundle check --file=Brewfile` to see what's missing and `brew bundle cleanup --file=Brewfile` to list installed packages that aren't declared (add `--force` to remove them).

# What's Included?

## Core Tools (02-homebrew.sh, Brewfile)

- `homebrew` - https://brew.sh
- `zsh` - Built-in macOS zsh shell with symlinked config
- `sheldon` - ZSH plugin manager
- `fzf` - Fuzzy finder
- `zoxide` - Smarter cd command
- `starship` - https://starship.rs - Cross-shell prompt

## Development Tools (Brewfile)

- `ghostty` - https://ghostty.org - Modern terminal emulator
- `tmux` - https://github.com/tmux/tmux/wiki
- `neovim` - https://neovim.io (with `lua`, `luarocks`, `fd`, `ripgrep`)
- `git` - with `tig`, `git-delta`
- `mise` - https://mise.jdx.dev - Runtime version manager
- `docker` & `colima` - https://github.com/abiosoft/colima
- Additional CLI tools: `autoconf`, `curl`, `jq`, `ngrok`
- `fonts` - `Fira Code` with `Nerd Font` patched glyphs

## Applications (Brewfile)

- Alfred - https://www.alfredapp.com
- 1Password - https://1password.com (with CLI for SSH agent & commit signing)
- Firefox & Google Chrome browsers
- Visual Studio Code - https://code.visualstudio.com
- Dash - https://kapeli.com/dash
- TablePlus - https://tableplus.com
- Utility apps: Lunar, Pika

## Config Symlinks (04-symlinks.sh)

All configuration files are symlinked from this repo:

- ZSH: sheldon plugins, starship prompt
- Terminal: ghostty, tmux
- Editor: neovim (full lua config), VS Code settings via extensions
- Git: gitconfig, gitignore, tigrc
- 1Password SSH agent config (for commit signing)
- Docker config (`credsStore: osxkeychain` keeps registry tokens in the Keychain)
- mise runtime versions
- Claude Code settings & statusline

## Claude Configuration (llms/claude/)

Configuration for both [Claude.ai](https://claude.ai) and [Claude Code](https://claude.ai/code), symlinked to `~/.claude/` by `04-symlinks.sh`.

| File             | Symlink Target             | Purpose                                                       |
| ---------------- | -------------------------- | ------------------------------------------------------------- |
| `CLAUDE.md`      | `~/.claude/CLAUDE.md`      | User-level preferences (code style, stack, git conventions)   |
| `settings.json`  | `~/.claude/settings.json`  | Claude Code settings (permissions, hooks, model, status line) |
| `rules/`         | `~/.claude/rules/`         | Language directives (applies to subagents too)                |
| `output-styles/` | `~/.claude/output-styles/` | Response voice and formatting                                 |
| `skills/`        | `~/.claude/skills/`        | User-level agent skills                                       |
| `scripts/`       | `~/.claude/scripts/`       | Status line, notification, and hook scripts                   |

**Dual-purpose files**: `CLAUDE.md` and `output-styles/voice-and-format.md` are loaded by Claude Code as project/global instructions. Their content must also be copied manually to Claude.ai under **Settings > User Preferences** to maintain consistent behavior across both interfaces.

Agent skills live in `.claude/skills/` (e.g., `neovim-lua-config` for Neovim Lua patterns).

### You are in business! 🚀
