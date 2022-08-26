source ~/.dotfiles/var.sh

# lang
export LANG=ja_JP.UTF-8

# history
export HISTFILE="$XDG_STATE_HOME/shell_history"
HISTSIZE=10000
SAVEHIST=10000

export LESSHISTFILE=-

# homebrew
[[ "$(uname)" == 'Darwin' ]] && [[ "$(uname -m)" == 'arm64' ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ "$(uname)" == 'Linux' ]] && eval "$($HOME/.linuxbrew/bin/brew shellenv)"

# terminal
export TERMINFO="$XDG_DATA_HOME/terminfo"

# python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export IPYTHONDIR="$XDG_DATA_HOME/jupyter"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
