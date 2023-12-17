declare -x FPATH="$XDG_DATA_HOME/zsh/site-functions:$FPATH"

unsetopt beep
setopt correct

# prohibit overwriting existing files
set -o noclobber
# prohibit exiting with Ctrl-D
set -o ignoreeof

# completion
zstyle ':completion:*' menu select interactive
setopt menu_complete

# node
declare -x NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
type fnm > /dev/null 2>&1 && eval "$(fnm env --use-on-cd)"

# rust
declare -x RUSTUP_HOME="$XDG_DATA_HOME/rustup"
declare -x CARGO_HOME="$XDG_DATA_HOME/cargo"
type rustup-init > /dev/null 2>&1 && source "$CARGO_HOME/env"
