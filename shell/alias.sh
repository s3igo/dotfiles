# homebrew
alias b='brew'

# VSCode
alias c='code -g'

# docker
alias d='docker'

# exa
alias exa='exa -a --icons'

# git
alias g='git'

#tmux
alias t='tmux'

# shell
## -i
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

## cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## ls
alias la='ls -hla --color=auto'
alias ll='ls -hl --color=auto'
alias ls='ls --color=auto'

# others
alias _cd='cd $_'
alias _login='exec $SHELL -l'

# mac
if [ "$(uname)" = 'Darwin' ]; then
    alias _do='eval "$(pbpaste)"'
    alias _ql='qlmanage -p "$1" >& /dev/null'
fi
