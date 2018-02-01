# direnv
eval "$(direnv hook zsh)"

# GnuPG2
export GPG_TTY=$(tty)

# asdf
autoload -Uz compinit && compinit
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# yarn
export PATH="$HOME/.yarn/bin:$PATH"
