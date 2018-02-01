alias zreload='source ~/.zshrc'

# files / directories
alias ll='ls -lhAG'

# navigation
alias ..='cd .. && pwd'
alias cd..='cd .. && pwd'
alias ...='cd ../.. && pwd'
alias ....='cd ../../.. && pwd'

# elixir
alias exsr='nv .env mix phx.server'
alias exdb='mix deps.get'
alias exts='nv .env.test mix test'
alias exfm='mix format'
alias excd='mix credo'

# ruby
alias be='bundle exec'

# Docker
alias dk='docker'
alias dkc='docker-compose'

# Terraform
alias tf='terraform'

# mkdir then cd in it!
take () {
  mkdir "$1"
  cd "$1"
}

