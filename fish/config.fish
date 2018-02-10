# Ensure fisherman is installed
if not test -f ~/.config/fish/functions/fisher.fish
  echo "Installing fisherman for the first time"
  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
  fisher
end

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch 369
set __fish_git_prompt_color_upstream_ahead (set_color green)
set __fish_git_prompt_color_upstream_behind (set_color red)

# Status Chars
set __fish_git_prompt_char_stateseparator '|'
set __fish_git_prompt_char_cleanstate '✔'
set __fish_git_prompt_char_dirtystate '✚'
set __fish_git_prompt_char_stagedstate '●'
set __fish_git_prompt_char_untrackedfiles '…'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind ' ↓'

# Greeting screen
set fish_greeting ''

# Alias
alias ll='ls -lhAG'
alias be='bundle exec'
alias dk='docker'
alias dkc='docker-compose'
alias tf='terraform'

# vi-mode
fish_vi_key_bindings

# direnv
eval (direnv hook fish)

# Prompt
set fish_prompt_pwd_dir_length 0

function fish_mode_prompt
end

function fish_prompt
  printf '%s%s%s%s' \
    (set_color blue) \
    (prompt_pwd) \
    (set_color normal) \
    (__fish_git_prompt)
  
  # prompt
  printf '\n%s> %s' \
    (set_color red) \
    (set_color normal)
end
