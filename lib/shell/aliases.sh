# homebrew
alias b='brew'

# VSCode
alias c='code -g'

# docker
alias d='docker'

# exa
alias exa='exa -a --icons'

# gcc
alias gcc='gcc-12'
alias g++='g++-12'

# git
alias g='git'
alias gca='git commit --amend --no-edit'
alias ginit="git init && git commit --allow-empty -m 'initial commit'"
alias gplr='git pull --rebase'
function gplPR() {
    git fetch origin "pull/$1/head:PR-$1"
}
alias gpsh='git push origin HEAD'
alias gpsm='git push origin main'

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
