alias zreload='. ~/.zshrc'

# navigation
alias ls='ls -G'
alias ll='ls -laG'
alias ld='ls -lG | grep "^d"'

alias ..='cd .. && pwd'
alias cd..='cd .. && pwd'
alias ...='cd ../.. && pwd'
alias ....='cd ../../.. && pwd'

#mysql
alias mysql_start='sudo /usr/local/mysql/support-files/mysql.server start'
alias mysql_stop='sudo /usr/local/mysql/support-files/mysql.server stop'
