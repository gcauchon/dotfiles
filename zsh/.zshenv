# PATH: deduplicated, user-local binaries first
typeset -U path PATH
path=("$HOME/.local/bin" $path)

# Erlang REPL
export ERL_AFLAGS='-kernel shell_history enabled'

# bat (cat replacement) — OneDark to match terminal theme
export BAT_THEME='OneDark'
