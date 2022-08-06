# common
## lang
export LANG=ja_JP.UTF-8

## history
HISTSIZE=10000
SAVEHIST=10000

# homebrew
[ "$(uname -m)" = 'arm64' ] && eval "$(/opt/homebrew/bin/brew shellenv)"
