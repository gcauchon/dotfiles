# PATH/FPATH: deduplicated, user-local binaries first
typeset -U path PATH fpath FPATH
path=("$HOME/.local/bin" $path)

# Default editor (git, kubectl edit, crontab -e, etc.)
export EDITOR=nvim
export VISUAL=nvim

# Erlang REPL
export ERL_AFLAGS="-kernel shell_history enabled"

# Docker
# BuildKit's tty renderer emits ANSI redraw escapes; only ask for it on a real
# tty. Docker's default (auto) already detects correctly on its own, so
# non-interactive shells (Claude Code's Bash tool, CI) get plain output.
# Explicit unset in the else branch: a non-tty child otherwise inherits
# whatever the parent shell (a real terminal) already exported.
if [[ -t 1 ]]; then
  export BUILDKIT_PROGRESS=tty
else
  unset BUILDKIT_PROGRESS
fi

# Non-interactive shells: fail fast instead of blocking on a prompt nothing
# can answer.
if [[ ! -t 0 ]]; then
  export GIT_TERMINAL_PROMPT=0
  export GIT_SSH_COMMAND='ssh -o BatchMode=yes'
else
  unset GIT_TERMINAL_PROMPT GIT_SSH_COMMAND
fi

# Ripgrep — search hidden/gitignored files by default
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
