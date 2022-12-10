# auto correct
setopt CORRECT

# beep
unsetopt BEEP

# history
declare -x HISTFILE="${XDG_STATE_HOME}/zsh_history"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

function zshaddhistory {
    local LINE=${1%%$'\n'}
    local CMD=${LINE%% *}

    [[ ${CMD} != (l[sal])
        && ${CMD} != 'cd'
        && ${CMD} != 'rip'
    ]]
}

function __update_history {
    local EXIT_STATUS="$?"

    fc -W
    if [[ ${EXIT_STATUS} != 0 ]]; then
        ed -s "$HISTFILE" <<EOF >/dev/null
d
w
q
EOF
    fi
}

precmd_functions+=(__update_history)

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
