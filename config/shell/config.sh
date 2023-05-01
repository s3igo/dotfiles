# lang
declare -x LANG=ja_JP.UTF-8

# history
declare -x HISTSIZE=10000
declare -x SAVEHIST=10000

# prohibit to overwrite
set -o noclobber

# homebrew
type brew > /dev/null 2>&1 \
    && [[ "$(uname)" == 'Darwin' ]] \
    && [[ "$(uname -m)" == 'arm64' ]] \
    && eval "$(/opt/homebrew/bin/brew shellenv)"

declare -x PATH="${PATH}:/usr/local/sbin"

# terminfo
declare -x TERMINFO="${XDG_DATA_HOME}/terminfo"
declare -x TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

# node
declare -x PATH="${PATH}:/usr/local/opt/node@16/bin"
declare -x NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# lesshist
declare -x LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# editor
declare -x EDITOR='nvim'

# ssh
declare -x SSH_AUTH_SOCK="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# zk
declare -x ZK_NOTEBOOK_DIR="${HOME}/src/github.com/s3igo/notes"

# alias
alias b='brew'
alias c='code'
alias d='docker'
alias g='git'
alias lg='lazygit'
alias nv='nvim'

## -i
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

## cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

## ls
function ls {
    exa --icons --git 2> /dev/null $@ || command ls $@
}
function la {
    exa -la --icons --git 2> /dev/null $@ || command ls -la $@
}
alias al='la' # in case of typo

## others
alias cdf='cd $_'
alias restart='exec $SHELL -l'
alias mkdri='mkdir' # in case of typo

## mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias ql='qlmanage -p "$1" >& /dev/null'
fi

# function
function timestamp {
    [[ $# == 0 ]] && date '+%Y%m%d%H%M%S' && return 0
    [[ $# > 1 ]] && echo 'error: too many arguments' && return 1

    declare extention="${1##*.}"
    declare now="$(date +%Y%m%d%H%M%S)"
    command mv "$1" "${now}.${extention}"
}
