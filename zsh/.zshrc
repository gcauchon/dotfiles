# Aliases
alias ll='ls -oah --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias mkp='mkdir --parents'
alias rmd='rmdir'
alias zreload='. ~/.zshrc'

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# Homebrew
# eval "$(brew shellenv)" MacOS
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# mise (version manager)
eval "$(mise activate zsh)"

# Sheldon (plugin manager)
# Add to PATH since the simplet Sheldon install was using Cargo
export PATH="$HOME/.cargo/bin:$PATH"
eval "$(sheldon source)"

# Starship (prompt SDKs versions)
eval "$(starship init zsh)"

# Completion
autoload -Uz compinit
compinit
