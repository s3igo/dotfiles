# lang
declare -x LANG=ja_JP.UTF-8

# history
declare HISTSIZE=10000
declare SAVEHIST=10000

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

# zk
declare -x ZK_NOTEBOOK_DIR="${HOME}/src/github.com/s3igo/notes"
