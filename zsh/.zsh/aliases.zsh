alias zreload='source ~/.zshrc'

# files / directories
alias ls='ls -G'
alias ll='ls -lahG'
alias ld='ls -lG | grep "^d"'

# navigation
alias ..='cd .. && pwd'
alias cd..='cd .. && pwd'
alias ...='cd ../.. && pwd'
alias ....='cd ../../.. && pwd'

# Myca gateway
alias gateway='ssh gcauchon@gw.myca.pvt'

# mkdir then cd in it!
take () {
  mkdir "$1"
  cd "$1"
}
