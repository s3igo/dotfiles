alias b='brew'
alias c='code'
alias d='docker'
alias g='git'
alias ra='ranger'

# -i
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ls
alias ls='exa --icons --git'
alias la='exa -la --icons --git'

# others
alias dir='cd $_'
alias _login='exec $SHELL -l'

# mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias pst='eval "$(pbpaste)"'
    alias ql='qlmanage -p "$1" >& /dev/null'
fi
