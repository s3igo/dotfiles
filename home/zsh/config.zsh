export LANG="en_US.UTF-8"
export EDITOR="nvim"

unsetopt beep
setopt correct

# avoid overwriting existing files
set -o noclobber

# avoid exiting with Ctrl-D
set -o ignoreeof

# avoid duplicate paths
typeset -U path cdpath fpath manpath

# completion
autoload -U compinit && compinit
zstyle ':completion:*' menu select interactive
setopt menu_complete
zmodload -i zsh/complist
bindkey -M menuselect '^N' down-line-or-history
bindkey -M menuselect '^P' up-line-or-history

# use emacs keymap as the default
bindkey -e

# bindkey
bindkey '^U' backward-kill-line

# aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias cdla='cd $_'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

alias eza='eza --icons --git'
alias la='eza -a'
alias ll='eza -l'
alias lla='eza -la'
alias ls='eza'
alias lt='eza --tree'

alias g='git'
alias nv='nvim'
alias restart='exec $SHELL -l'
alias mkdri='mkdir'

alias -g @i='install'
alias -g @s='search'
alias -g @u='uninstall'
