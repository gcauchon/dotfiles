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
- `fish` - https://fishshell.com
- `gnupg` - https://gnupg.org
- `tmux` - https://github.com/tmux/tmux/wiki
- `neovim` - https://neovim.io
- `asdf` - https://asdf-vm.com, with plugins for `erlang`, `elixir`, `node` and `ruby`
- `direnv` - https://direnv.net
- `fonts` - `Fira Code`, `JetBrains Mono`; with `Nerd Font` patched glyphs
- configurations files

Plus many apps I am using every day:

- iTerm2 - https://iterm2.com
- Alfred - https://www.alfredapp.com
- 1Password - https://1password.com
- Docker - https://www.docker.com/products/docker-desktop
- Dash - https://kapeli.com/dash
- TablePlus - https://tableplus.com
- Spotify - https://www.spotify.com
- and many more…

4. Run each `.sh` scripts sequentially.

```shell
> ./01-default.sh
…
> ./02-homebrew.sh
…
```

### You are in business! 🚀
