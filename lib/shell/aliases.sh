# VSCode
alias c='code -g'

# homebrew
alias b='brew'

# docker
alias d='docker'

# exa
alias exa='exa -a --icons'

# git
alias g='git'
alias gca='git commit --amend --no-edit'
alias ginit="git init && git commit --allow-empty -m 'initial commit'"
alias gplr='git pull --rebase'
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

# mac specific commands
if [ "$(uname)" = 'Darwin' ]; then
    alias _ql='qlmanage -p "$1" >& /dev/null'
fi
