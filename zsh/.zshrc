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
for file in $ZSH/{exports,aliases,syntax,functions}.zsh; do
    [ -r "$file" ] && source "$file"
done
unset file

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load completion file after autocomplete
source $ZSH/completion.zsh

# colours variables
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
  colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE BLACK; do
  eval PR_$color='%{$fg_no_bold[${(L)color}]%}'
  eval PR_BOLD_$color='%{$fg_bold[${(L)color}]%}'
done

export PR_RESET='$reset_color'
export PR_RED PR_GREEN PR_YELLOW PR_BLUE PR_WHITE PR_BLACK
export PR_BOLD_RED PR_BOLD_GREEN PR_BOLD_YELLOW PR_BOLD_BLUE 
export PR_BOLD_WHITE PR_BOLD_BLACK

# Prompt
PROMPT="$PR_BLUE%n$PR_GREEN@%m $PR_RED$ "
RPROMPT="$PR_WHITE%~"


unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help
