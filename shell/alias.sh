alias b='brew'
alias c='code'
alias d='docker'
alias e='exa --icons --git'
alias ea='exa -la --icons --git'
alias g='git'
alias t='tmux'

# -i
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# others
alias dir='cd $_'
alias _login='exec $SHELL -l'

# mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias pst='eval "$(pbpaste)"'
    alias ql='qlmanage -p "$1" >& /dev/null'
fi
