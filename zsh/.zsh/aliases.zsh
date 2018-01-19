alias zreload='source ~/.zshrc'

# files / directories
alias ll='ls -lhAG'

# navigation
alias ..='cd .. && pwd'
alias cd..='cd .. && pwd'
alias ...='cd ../.. && pwd'
alias ....='cd ../../.. && pwd'

# docker
alias dk='docker'
alias dkc='docker-compose'

# elixir
alias exsr='nv .env mix phx.server'
alias exdb='mix deps.get'
alias exts='nv .env.test mix test'
alias exfm='mix format'
alias excd='mix credo'

# ruby
alias be='bundle exec'

# docker
alias dk='docker'
alias dkc='docker-compose'

# mkdir then cd in it!
take () {
  mkdir "$1"
  cd "$1"
}

