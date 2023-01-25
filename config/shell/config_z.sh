# auto correct
setopt correct

# beep
unsetopt beep

# history
declare -x HISTFILE="${XDG_STATE_HOME}/zsh_history"
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history

# custom variables
function __export_date {
    declare -x DATE="$(date +%Y-%m-%d)"
}

precmd_functions+=(__export_date)

# direnv
type direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"

# GitHub CLI
type gh > /dev/null 2>&1 && eval "$(gh completion -s zsh)"

# alias
## shell
alias -g @i='install'
alias -g @latest='"$(command ls -rt $1 | tail -n 1)"'

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
bindkey -e # explicit use emacs keybind
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
