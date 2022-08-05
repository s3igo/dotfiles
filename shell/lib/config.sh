# common
## lang
export LANG=ja_JP.UTF-8

## auto correct
set -o CORRECT_ALL

## beep
set +o BEEP

## history
HISTSIZE=10000
SAVEHIST=10000
set -o HIST_IGNORE_ALL_DUPS
set -o HIST_REDUCE_BLANKS
set -o INC_APPEND_HISTORY

# homebrew
[ "$(uname -m)" = 'arm64' ] && eval "$(/opt/homebrew/bin/brew shellenv)"
