# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.zsh

HISTSIZE=1000
SAVEHIST=500
HISTFILE=$ZSH/.history

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS

# load everything but the path and completion files
for file in $ZSH/{exports,aliases,functions}.zsh; do
	[ -r "$file" ] && source "$file"
done
unset file

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load completion file after autocomplete
source $ZSH/completion.zsh

# custom PROMPT
#
PROMPT="%{$fg[blue]%}%n%{$reset_color%}[%{$fg[green]%}%~%{$reset_color%}]$ "
