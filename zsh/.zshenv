typeset -U path PATH
path=(
  $HOME/.local/bin
  $HOME/.cargo/bin
  $path
)

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Default editor (git, kubectl edit, crontab -e, etc.)
export EDITOR=nvim
export VISUAL=nvim

# Erlang REPL
export ERL_AFLAGS='-kernel shell_history enabled'

# Docker
export BUILDKIT_PROGRESS=tty
export DOCKER_DEFAULT_PLATFORM=linux/amd64
