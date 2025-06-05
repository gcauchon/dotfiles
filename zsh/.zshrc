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
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

# Completion
autoload -Uz compinit
compinit

# Sheldon, ZSH plugin manager
eval "$(sheldon source)"

# Starship prompt
eval "$(starship init zsh)"

# mise (version manager)
eval "$(mise activate zsh)"
