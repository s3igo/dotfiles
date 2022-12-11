# lang
declare -x LANG=ja_JP.UTF-8

# history
declare -x HISTSIZE=10000
declare -x SAVEHIST=10000

# prohibit to overwrite
set -o noclobber

# homebrew
[[ "$(uname)" == 'Darwin' ]] && [[ "$(uname -m)" == 'arm64' ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
declare -x PATH="${PATH}:/usr/local/sbin"

# terminfo
declare -x TERMINFO="${XDG_DATA_HOME}/terminfo"
declare -x TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

# node for copilot
declare -x PATH="${PATH}:/usr/local/opt/node@16/bin"

# lesshist
declare -x LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# editor
declare -x EDITOR='nvim'

# ranger
[[ -n "$RANGER_LEVEL" ]] && PS1="ranger ${PS1}"

# zk
declare -x ZK_NOTEBOOK_DIR="${HOME}/src/github.com/s3igo/notes"

# alias
alias b='brew'
alias c='code'
alias d='docker'
alias g='git'
alias lg='lazygit'
alias nv='nvim'
alias ra='ranger'

## -i
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

## cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## ls
alias ls='exa --icons --git 2> /dev/null || command ls'
alias la='exa -la --icons --git 2> /dev/null || command ls -la'
alias al='la' # in case of typo

## others
alias cdf='cd $_'
alias restart='exec $SHELL -l'

## mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias ql='qlmanage -p "$1" >& /dev/null'
fi
