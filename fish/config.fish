# Ensure fisherman is installed
if not test -f ~/.config/fish/functions/fisher.fish
  echo "Installing fisherman for the first time"
  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  fisher
end

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showcolorhints 'yes'

set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_upstream_prefix ' '

set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '$'
set __fish_git_prompt_char_untrackedfiles '?'
set __fish_git_prompt_char_stashstate '#'
set __fish_git_prompt_char_invalidstate '!'

# Homebrew
set -U fish_user_paths '/opt/homebrew/bin' $fish_user_paths
fish_add_path /opt/homebrew/sbin

# Alias
alias ll='ls -lhag'

# vi-mode
fish_vi_key_bindings

# GPG
set -x GPG_TTY (tty)

# Starship
starship init fish | source

# mise
mise activate fish | source

# colima
colima completion fish | source

# Erlang REPL
set -x ERL_AFLAGS '-kernel shell_history enabled'
