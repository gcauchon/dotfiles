# GPG (interactive passphrase prompts)
export GPG_TTY=$(tty)

# Aliases
alias ll='ls -oah --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias mkp='mkdir --parents'
alias rmd='rmdir'
alias zreload='. ~/.zshrc'

alias code="/mnt/c/Users/guillaume.cauchon/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"

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

# mise (version manager)
eval "$(mise activate zsh)"

# Sheldon (plugin manager)
eval "$(sheldon source)"

# Starship (prompt SDKs versions)
eval "$(starship init zsh)"

# SSH agent (keychain) for WSL2 shells
if [[ -n "${WSL_INTEROP:-}" ]] && command -v keychain >/dev/null 2>&1; then
  eval "$(keychain --quiet --eval ~/.ssh/id_ed25519 ~/.ssh/id_rsa-4096)"
fi

# Completion (cache compdump, re-check once per day)
autoload -Uz compinit
if [[ ! -f ~/.zcompdump || -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
