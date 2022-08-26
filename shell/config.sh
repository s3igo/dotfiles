source ~/.dotfiles/var.sh

# lang
declare -x LANG=ja_JP.UTF-8

# history
declare -x HISTFILE="${XDG_STATE_HOME}/shell_history"
declare HISTSIZE=10000
declare SAVEHIST=10000

declare -x LESSHISTFILE=-

# homebrew
[[ "$(uname)" == 'Darwin' ]] && [[ "$(uname -m)" == 'arm64' ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ "$(uname)" == 'Linux' ]] && eval "$(${HOME}/.linuxbrew/bin/brew shellenv)"

# terminal
declare -x TERMINFO="${XDG_DATA_HOME}/terminfo"

# python
declare -x PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/startup.py"
declare -x IPYTHONDIR="${XDG_DATA_HOME}/jupyter"
declare -x JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"
