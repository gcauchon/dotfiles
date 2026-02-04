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
eval "$(brew shellenv)"

# Sheldon, ZSH plugin manager
eval "$(sheldon source)"

# Starship prompt
eval "$(starship init zsh)"

# mise (version manager)
eval "$(mise activate zsh)"

# Completion
autoload -Uz compinit
compinit
