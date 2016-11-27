alias zreload='source ~/.zshrc'

# files / directories
alias ll='ls -lhAG'

# navigation
alias ..='cd .. && pwd'
alias cd..='cd .. && pwd'
alias ...='cd ../.. && pwd'
alias ....='cd ../../.. && pwd'

# ruby
alias be='bundle exec'

# docker
alias docker-machine-apps='eval $(docker-machine env apps)'

# mkdir then cd in it!
take () {
  mkdir "$1"
  cd "$1"
}

