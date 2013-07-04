alias zreload='source ~/.zshrc'

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

#wakeonlan
alias wake_nas='wakeonlan -i 192.168.1.200 2C:B0:5D:BF:07:B7'
