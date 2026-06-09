typeset -U path PATH fpath FPATH
path=(
  $HOME/.local/bin
  $HOME/.cargo/bin
  $path
)

# Homebrew
if [[ -z "$HOMEBREW_PREFIX" ]]; then                                                                      
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"                                                  
fi

# Default editor (git, kubectl edit, crontab -e, etc.)
export EDITOR=nvim
export VISUAL=nvim

# Erlang REPL
export ERL_AFLAGS='-kernel shell_history enabled'

# Docker
export BUILDKIT_PROGRESS=tty
export DOCKER_DEFAULT_PLATFORM=linux/amd64
