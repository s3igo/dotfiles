alias b='brew'
alias c='code'
alias d='docker'
alias g='git'
alias lg='lazygit'
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
alias al='la' # in case of typo

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
    declare arg=${1:-$PWD}
    declare opt=''
    getopts 'l' opt
    if [[ "$opt" == 'l' ]]; then
        command ls -rtl "$arg" | tail -n 1
    else
        command ls -rt "$arg" | tail -n 1
    fi
}

function dir() {
    declare opt=''
    getopts 'a' opt
    if [[ "$opt" == 'a' ]]; then
        cd "$(fd -HI -t d -E .git -E node_modules | fzf)"
    else
        cd "$(fd -t d | fzf)"
    fi
}
