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

# python
declare -x PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/startup.py"
declare -x IPYTHONDIR="${XDG_DATA_HOME}/jupyter"
declare -x JUPYTER_CONFIG_DIR="${XDG_CONFIG_HOME}/jupyter"

# npm
declare -x NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"

# docker
# declare -x DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# lesshist
declare -x LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
