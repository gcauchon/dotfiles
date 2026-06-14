# PATH: deduplicated, user-local binaries first
typeset -U path PATH
path=("$HOME/.local/bin" $path)

# Default editor (git, kubectl edit, crontab -e, etc.)
export EDITOR=nvim
export VISUAL=nvim

# Erlang REPL
export ERL_AFLAGS='-kernel shell_history enabled'

# bat (cat replacement) — OneDark to match terminal theme
export BAT_THEME='OneDark'

# Docker — force TTY progress output (better for interactive terminals)
export BUILDKIT_PROGRESS=tty
