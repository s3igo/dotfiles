alias b='brew'
alias c='code'
alias d='docker'
alias e='exa --icons --git'
alias ea='exa -la --icons --git'
alias el='exa -l --icons --git'
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

# ls
alias la='ls -hla --color=auto'
alias ll='ls -hl --color=auto'
alias ls='ls --color=auto'

# others
alias _cd='cd $_'
alias _login='exec $SHELL -l'

# mac
if [ "$(uname)" = 'Darwin' ]; then
    alias _a='open -a "$(ls /Applications | sed "s/\.app$//" | fzf)"'
    alias _do='eval "$(pbpaste)"'
    alias _ql='qlmanage -p "$1" >& /dev/null'
fi
