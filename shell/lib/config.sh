# common
## lang
export LANG=ja_JP.UTF-8

## history
HISTSIZE=100000
SAVEHIST=1000000

# language
## anyenv
which anyenv > /dev/null 2>&1 && eval "$(anyenv init -)"

## ghcup-env
which ghcup > /dev/null 2>&1 && [ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
