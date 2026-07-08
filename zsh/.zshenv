# PATH: deduplicated, user-local binaries first
typeset -U path PATH
path=("$HOME/.local/bin" $path)

# Default editor (git, kubectl edit, crontab -e, etc.)
export EDITOR=nvim
export VISUAL=nvim

# Erlang REPL
export ERL_AFLAGS="-kernel shell_history enabled"

# Docker — force TTY progress output (better for interactive terminals)
export BUILDKIT_PROGRESS=tty

# Ripgrep — search hidden/gitignored files by default
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
