# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.zsh

export TERM="xterm-256color"

setopt AUTO_CD # If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt APPEND_HISTORY # Allow multiple terminal sessions to all append to one zsh command history
setopt EXTENDED_HISTORY # save timestamp of command and duration
setopt HIST_IGNORE_DUPS # Do not write events to history that are duplicates of previous events
setopt HIST_REDUCE_BLANKS # Remove extra blanks from each command line being added to history

# ===== Completion 
setopt ALWAYS_TO_END # When completing from the middle of a word, move the cursor to the end of the word    
setopt AUTO_MENU # Show completion menu on successive tab press. needs unsetop menu_complete to work
setopt AUTO_NAME_DIRS # Any parameter that is set to the absolute name of a directory immediately becomes a name for that directory
setopt COMPLETE_IN_WORD # Allow completion from within a word/phrase

unsetopt MENU_COMPLETE # Do not autoselect the first completion entry

# ===== Correction
unsetopt CORRECT_ALL # Spelling correction for arguments
setopt CORRECT # Spelling correction for commands

setopt PROMPT_SUBST # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt

# history
export HISTSIZE=1200
export SAVEHIST=1000
export HISTFILE=$ZSH/.history

# zsh modules
zmodload -a zsh/stat stat
#zmodload -a zsh/zprof zprof

# load everything but the path and completion files
for file in $ZSH/{exports,aliases}.zsh; do
    [ -r "$file" ] && source "$file"
done
unset file

# completion and custom functions
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=(~/.zsh/completion $fpath)

# Fish shell like syntax highlighting for Zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Fish-like fast/unobtrusive autosuggestions for zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"

autoload -U compinit && compinit

# Prompt
PROMPT="%F{39}%n@%m %F{160}>%f "
RPROMPT="%F{117}%3~%f"
