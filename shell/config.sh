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
[[ "$(uname)" == 'Linux' ]] && eval "$(${HOME}/.linuxbrew/bin/brew shellenv)"

# asdf
declare -x ASDF_CONFIG_FILE="${XDG_CONFIG_HOME}/asdf/asdfrc"
declare -x ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
source "$(brew --prefix asdf)/libexec/asdf.sh"

# terminfo
declare -x TERMINFO="${XDG_DATA_HOME}/terminfo"
declare -x TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo:/usr/share/terminfo"

# python
declare -x PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
declare -x IPYTHONDIR="${XDG_DATA_HOME}/jupyter"
declare -x JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"

# node
declare -x NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
declare -x NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"

# lesshist
declare -x LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# editor
declare -x EDITOR='nvim'
bindkey -e # explicit use emacs keybind
