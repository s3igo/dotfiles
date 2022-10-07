alias b='brew'
alias c='code'
alias d='docker'
alias g='git'
alias nv='nvim'
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
alias cdf='cd $_'
alias _login='exec $SHELL -l'

# mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias pst='eval "$(pbpaste)"'
    alias ql='qlmanage -p "$1" >& /dev/null'
fi

# kitty
[[ "$TERM" == 'xterm-kitty' ]] && alias ssh='kitty +kitten ssh'

# functions
function latest() {
    local arg=${1:-$PWD}
    command ls -rt "$arg" | tail -n 1
}

function dir() {
    getopts 'a' opt
    if [[ "$opt" == 'a' ]]; then
        cd "$(fd -HI -t d -E .git -E node_modules | fzf)"
    else
        cd "$(fd -t d | fzf)"
    fi
}
