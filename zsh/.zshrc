# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.zsh

# mysql
export PATH=$PATH:/usr/local/mysql/bin

# rbenv
export PATH=$PATH:$HOME/.rbenv/bin
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# all of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# load everything but the path and completion files
for file in ${config_files:#*/completion.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
  source $file
done

unset config_files
