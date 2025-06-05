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

2. Customize `01-defaults.sh` with MacOS tweaks to include; or not.

3. Customize `02-homebrew.sh` with the tools and application needed.

Here are the main tools that are included:

- `homebrew` - https://brew.sh
- `zsh` - Built-in macOS zsh shell with plugins (`sheldon`, `fzf`, `zoxide`)
- `starship` - https://starship.rs - Cross-shell prompt
- `tmux` - https://github.com/tmux/tmux/wiki
- `neovim` - https://neovim.io (with `lua`, `luarocks`, `fd`, `ripgrep`)
- `git` - with `tig`, `diff-so-fancy`
- `gnupg` - https://gnupg.org (with `pinentry-mac`)
- `mise` - https://mise.jdx.dev/getting-started.html
- `docker` & `colima` - https://github.com/abiosoft/colima
- Additional CLI tools: `autoconf`, `curl`, `jq`, `ngrok`
- `fonts` - `Fira Code` with `Nerd Font` patched glyphs

Plus many apps I am using every day:

- Ghostty - https://ghostty.org - Modern terminal emulator
- Alfred - https://www.alfredapp.com
- 1Password - https://1password.com (with CLI)
- Firefox & Google Chrome browsers
- Visual Studio Code - https://code.visualstudio.com
- Dash - https://kapeli.com/dash
- TablePlus - https://tableplus.com
- Slack - https://slack.com
- Spotify - https://www.spotify.com
- Utility apps: Caffeine, ImageOptim, Gifox, LanguageTool, Lunar, Pika

4. Run each `.sh` scripts sequentially.

```shell
> ./01-defaults.sh
…
> ./02-homebrew.sh
…
```

### You are in business! 🚀
