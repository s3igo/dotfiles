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
alias dir='cd "$(fd -t d | fzf)"'
alias dir-a='cd "$(fd -HI -t d -E .git -E node_modules | fzf)"'
alias _login='exec $SHELL -l'

# mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias pst='eval "$(pbpaste)"'
    alias ql='qlmanage -p "$1" >& /dev/null'
fi

# kitty
[[ "$TERM" == 'xterm-kitty' ]] && alias ssh='kitty +kitten ssh'
