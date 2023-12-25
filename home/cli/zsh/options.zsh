declare -x FPATH="$XDG_DATA_HOME/zsh/site-functions:$FPATH"

unsetopt beep
setopt correct

# prohibit overwriting existing files
set -o noclobber
# prohibit exiting with Ctrl-D
set -o ignoreeof

# completion
# autoload -Uz compinit && compinit -u
zstyle ':completion:*' menu select interactive
setopt menu_complete
zmodload -i zsh/complist
bindkey -M menuselect '^N' down-line-or-history
bindkey -M menuselect '^P' up-line-or-history

# node
declare -x NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
type fnm > /dev/null 2>&1 && eval "$(fnm env --use-on-cd)"
