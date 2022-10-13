# global
## shell
alias -g @f='| fzf'
alias -g @g='| grep'
alias -g @i='install'
alias -g @latest='"$(_latest)"'
alias -g @latest-a='latest -a'

## docker
alias -g @dp='`docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | fzf | cut -d " " -f 1`'
alias -g @dp-a='`docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | fzf | cut -d " " -f 1`'

## mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias -g @cp='| pbcopy'
    alias -g @pst='"$(pbpaste)"'
fi

# keybind
bindkey '^U' backward-kill-line

## cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zle -N anyframe-widget-cdr
bindkey '^S' anyframe-widget-cdr

## command history
zle -N anyframe-widget-execute-history
bindkey '^R' anyframe-widget-execute-history

## ghq
zle -N anyframe-widget-cd-ghq-repository
bindkey '^G' anyframe-widget-cd-ghq-repository
