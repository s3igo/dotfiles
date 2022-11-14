# global
## shell
alias -g @i='install'
alias -g @latest='"$(_latest)"'
alias -g @latest-a='latest -a'

## docker
alias -g @d_ps='"$(docker ps | tail -n +2 | fzf | read ID IMAGE COMMAND CREATED STATUS PORTS NAMES && echo $ID)"'
alias -g @d_ps-a='"$(docker ps -a | tail -n +2 | fzf | read ID IMAGE COMMAND CREATED STATUS PORTS NAMES && echo $ID)"'
alias -g @d_images='"$(docker images | tail -n +2 | fzf | read REPOSITORY TAG IMAGEID CREATED SIZE && echo $IMAGEID)"'


## mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias -g @cp='| pbcopy'
    alias -g @pst='"$(pbpaste)"'
fi

# keybind
bindkey '^U' backward-kill-line
bindkey '^J' menu-select

## cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zle -N anyframe-widget-cdr
bindkey '^S' anyframe-widget-cdr

## command history
zle -N anyframe-widget-execute-history
bindkey '^R' anyframe-widget-execute-history

## ghq
function __ghq-fzf {
    anyframe-source-ghq-repository \
        | fzf --preview "command exa --tree --git-ignore -I 'node_modules|.git' {}" \
        | anyframe-action-execute cd --
}
zle -N __ghq-fzf
bindkey '^G' __ghq-fzf
