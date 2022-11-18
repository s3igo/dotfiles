source ~/.dotfiles/var.sh

# lang
declare -x LANG=ja_JP.UTF-8

# history
declare HISTSIZE=10000
declare SAVEHIST=10000

# prohibit to overwrite
set -o noclobber

# homebrew
[[ "$(uname)" == 'Darwin' ]] && [[ "$(uname -m)" == 'arm64' ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
declare -x PATH="$PATH:/usr/local/sbin"

# terminfo
declare -x TERMINFO="${XDG_DATA_HOME}/terminfo"
declare -x TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

# python
declare -x PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
declare -x IPYTHONDIR="${XDG_DATA_HOME}/jupyter"
declare -x JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"

# node
declare -x NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
declare -x NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_repl_history"
export PATH="$PATH:/usr/local/opt/node@16/bin"

# lesshist
declare -x LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# editor
declare -x EDITOR='nvim'
bindkey -e # explicit use emacs keybind

# zk
declare -x ZK_NOTEBOOK_DIR="${HOME}/src/github.com/s3igo/notes"
