alias zreload='source ~/.zshrc'

# navigation
alias ls='ls -G'
alias ll='ls -laG'
alias ld='ls -lG | grep "^d"'

alias ..='cd .. && pwd'
alias cd..='cd .. && pwd'
alias ...='cd ../.. && pwd'
alias ....='cd ../../.. && pwd'

#wakeonlan
alias wake_nas='wakeonlan -i 192.168.1.255 2c:b0:5d:bf:07:b7'
