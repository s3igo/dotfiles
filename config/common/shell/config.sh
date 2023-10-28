# lang
declare -x LANG=ja_JP.UTF-8

# history
declare -x HISTSIZE=10000
declare -x SAVEHIST=10000

# prohibit to overwrite
set -o noclobber

# terminfo
declare -x TERMINFO="${XDG_DATA_HOME}/terminfo"
declare -x TERMINFO_DIRS="${TERMINFO}:/usr/share/terminfo"

# homebrew
[[ "$(uname -m)" == 'x86_64' ]] && declare -x PATH="${PATH}:/usr/local/sbin"

# docker
declare -x DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# node
declare -x NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
type fnm > /dev/null 2>&1 && eval "$(fnm env --use-on-cd)"

# rust
declare -x RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
declare -x CARGO_HOME="${XDG_DATA_HOME}/cargo"
type rustup-init > /dev/null 2>&1 && source "${CARGO_HOME}/env"

# broot
type broot > /dev/null 2>&1 && source "${XDG_CONFIG_HOME}/broot/launcher/bash/br"

# lesshist
declare -x LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# editor
declare -x EDITOR='nvim'

# helix
declare -x HELIX_RUNTIME="${XDG_CONFIG_HOME}/helix/runtime"

# zk
declare -x ZK_NOTEBOOK_DIR="${HOME}/git/github.com/s3igo/notes"

# alias
alias b='brew'
alias c='cargo'
alias d='docker'
alias g='git'
alias lzd='lazydocker'
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
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

## ls
function ls {
    eza --icons --git "$@" 2> /dev/null || command ls "$@"
}
function lt {
    eza -T --icons "$@" 2> /dev/null || command tree "$@"
}
function la {
    eza -la --icons --git "$@" 2> /dev/null || command ls -la "$@"
}
alias al='la' # in case of typo

## others
alias cdf='cd $_'
alias restart='exec $SHELL -l'
alias mkdri='mkdir' # in case of typo

# function
function timestamp {
    [[ $# == 0 ]] && date '+%Y%m%d%H%M%S' && return 0
    [[ $# > 1 ]] && echo 'error: too many arguments' && return 1

    declare ext="${1#*.}"
    declare now="$(date +%Y%m%d%H%M%S)"
    command mv "$1" "${now}.${ext}"
}

function tmux-backup {
    declare TARGET_DIR="${XDG_STATE_HOME}/tmux/resurrect"
    command ls "$TARGET_DIR" | sed '/last/d' | xargs -I{} dbxcli put "${TARGET_DIR}/{}" "src/tmux-resurrect/{}"
}

function tmux-restore {
    declare TARGET_DIR="${XDG_STATE_HOME}/tmux/resurrect"
    declare REMOTE_DIR="src/tmux-resurrect"
    mkdir -p "$TARGET_DIR"
    dbxcli ls "$REMOTE_DIR" | xargs -I{} basename {} | xargs -I{} dbxcli get "${REMOTE_DIR}/{}" "${TARGET_DIR}/{}"
    ln -fnsv "$(command ls "$TARGET_DIR" | tail -n 1)" "${TARGET_DIR}/last"
}

# mac
if [[ "$(uname)" == 'Darwin' ]]; then
    ## ssh
    declare -x SSH_AUTH_SOCK="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

    ## alias
    alias ql='qlmanage -p "$1" >& /dev/null'

    ## function
    if [[ "$(uname -m)" == 'arm64' ]]; then
        function rosetta {
            [[ $# == 0 ]] && arch -x86_64 zsh && return 0
            arch -x86_64 zsh -c "$*"
        }
    fi
    
    function hashmv {
        [[ $# == 0 ]] && echo 'error: missing argument' && return 1
        [[ $# > 1 ]] && echo 'error: too many arguments' && return 1

        declare EXT="${1#*.}"
        declare HASH="$(shasum -a 256 "$1" | cut -d ' ' -f 1)"
        declare NAME="${HASH}.${EXT}"

        mv "$1" "$NAME"
        echo "$NAME"
    }
fi

