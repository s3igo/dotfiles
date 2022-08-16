# shell
alias _start='source ~/.config/zsh/.zshrc'

# global
## shell
alias -g _head='cut -d " " -f 1'
alias -g _i='install'
alias -g _opt=anyframe-selector-auto

## docker
alias -g _dp='`docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | anyframe-selector-auto | cut -d " " -f 1`'
alias -g _dp-a='`docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | anyframe-selector-auto | cut -d " " -f 1`'

# mac
if [ "$(uname)" = 'Darwin' ]; then
    alias -g _pick='| anyframe-selector-auto | pbcopy'
    ## keybind
    function __open-app() {
        open -a "$(ls /Applications | sed 's/\.app$//' | anyframe-selector-auto)"
    }
    zle -N __open-app
    bindkey 'å' __open-app

    ### cdr
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zle -N anyframe-widget-cdr
    bindkey '^W' anyframe-widget-cdr

    ### command history
    zle -N anyframe-widget-execute-history
    bindkey '^R' anyframe-widget-execute-history

    ### ghq
    zle -N anyframe-widget-cd-ghq-repository
    bindkey '^G' anyframe-widget-cd-ghq-repository
fi
