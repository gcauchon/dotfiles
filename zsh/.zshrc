# GPG (interactive passphrase prompts). Guarded so non-interactive shells
# (Claude Code's Bash tool, scripts) never inherit a pty gpg-agent could
# write a prompt into — unset explicitly, since a non-tty child otherwise
# keeps whatever GPG_TTY the parent shell (a real terminal) already exported.
if [[ -t 0 ]]; then
  export GPG_TTY=$(tty)
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
else
  unset GPG_TTY
fi

# Aliases
alias ll='ls -oah --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias mkp='mkdir --parents'
alias rmd='rmdir'
alias zreload='exec zsh'

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
fpath=(~/.local/share/zsh/site-functions $fpath)
autoload -Uz compinit
if [[ ! -f ~/.zcompdump || -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Bash-style completions (tofu/terraform implement the `complete -C` protocol)
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C tofu tofu

# Generated completion scripts (az via argcomplete, npm — see 05-cleanup.sh)
for f in ~/.local/share/zsh/completions/*.zsh(N); do source "$f"; done
