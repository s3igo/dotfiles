# shell
alias _start='source ~/.config/zsh/.zshrc'

# global
## shell
alias -g @g='| grep'
alias -g @head='| cut -d " " -f 1'
alias -g @i='install'

## docker
alias -g @dp='`docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | fzf | cut -d " " -f 1`'
alias -g @dp-a='`docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | fzf | cut -d " " -f 1`'

# mac
if [ "$(uname)" = 'Darwin' ]; then
    ## global
    alias -g @pick='| fzf | pbcopy'
fi

# keybind
## cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zle -N anyframe-widget-cdr
bindkey '^W' anyframe-widget-cdr

## command history
zle -N anyframe-widget-execute-history
bindkey '^R' anyframe-widget-execute-history

## ghq
zle -N anyframe-widget-cd-ghq-repository
bindkey '^G' anyframe-widget-cd-ghq-repository
