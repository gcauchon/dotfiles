# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.zsh

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt correct # correct the spelling of commands
setopt extended_history # timestamps in the history file
setopt notify # background jobs status immediately
setopt prompt_subst # expansion in prompts

# history
export HISTSIZE=1000
export SAVEHIST=500
export HISTFILE=$ZSH/.history

# zsh modules
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -a zsh/mapfile mapfile

# load everything but the path and completion files
for file in $ZSH/{exports,aliases,syntax}.zsh; do
    [ -r "$file" ] && source "$file"
done
unset file

# completion and custom functions
autoload -U compinit
fpath=(/usr/local/share/zsh-completions $fpath)
compinit

# syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# colours variables
autoload -U colors && colors

# Prompt
PROMPT="%{$fg[blue]%}%n@%m %{$fg[red]%}%# %{$reset_color%}"
RPROMPT="%{$fg[white]%}%3~%{$reset_color%}"

# unalias run-help
# autoload run-help
# HELPDIR=/usr/local/share/zsh/help
