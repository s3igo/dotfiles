# lang
export LANG=ja_JP.UTF-8

# history
export HISTFILE="$HOME/.local/state/history"
HISTSIZE=10000
SAVEHIST=10000

export LESSHISTFILE=-

# homebrew
[ "$(uname -m)" = 'arm64' ] && eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$PATH:/usr/local/sbin"

# terminal
export TERMINFO="$HOME/.local/share/terminfo"
