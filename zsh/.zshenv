# PATH: deduplicated, user-local binaries first
typeset -U path PATH
path=("$HOME/.local/bin" $path)

# Erlang REPL
export ERL_AFLAGS='-kernel shell_history enabled'
