# common
## lang
export LANG=ja_JP.UTF-8

## history
HISTSIZE=100000
SAVEHIST=1000000

# homebrew
[ "$(uname -m)" = 'arm64' ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# nodenv
which nodenv > /dev/null 2>&1 \
	&& eval "$(nodenv init -)" \
	&& export PATH="$PATH:$HOME/.nodenv/bin"
