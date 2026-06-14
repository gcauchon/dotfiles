# Aliases
if command -v eza &>/dev/null; then
  alias ll='eza -lah --git'
else
  alias ll='ls -oahG'
fi
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
fi
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias mkp='mkdir --parents'
alias rmd='rmdir'
alias zreload='exec zsh'

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
setopt INTERACTIVE_COMMENTS
setopt EXTENDED_GLOB

# Homebrew
eval "$(brew shellenv)"

# Sheldon, ZSH plugin manager
eval "$(sheldon source)"

# Starship prompt
eval "$(starship init zsh)"

# mise (version manager)
eval "$(mise activate zsh)"

# fzf (key bindings + completion)
eval "$(fzf --zsh)"

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# Completion — full security check only when dump is older than 24 hours
fpath=(~/.local/share/zsh/site-functions $fpath)
autoload -Uz compinit
local zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
if [[ ! -d "${zcompdump:h}" ]]; then mkdir -p "${zcompdump:h}"; fi
if [[ -n "${zcompdump}"(#qNmh-24) ]]; then
  compinit -C -d "$zcompdump"   # skip security check, dump is fresh
else
  compinit -d "$zcompdump"      # full check, update dump
fi

# Bash-style completions (tofu/terraform use the `complete -C` protocol)
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C tofu tofu

# Generated completion scripts (az via argcomplete, npm — see 05-cleanup.sh)
for f in ~/.local/share/zsh/completions/*.zsh(N); do source "$f"; done
