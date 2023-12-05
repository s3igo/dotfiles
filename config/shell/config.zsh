# auto correct
setopt correct

# beep
unsetopt beep

# history
# declare -x HISTFILE="${XDG_STATE_HOME}/zsh_history"
unset HISTFILE
# setopt share_history
# setopt hist_ignore_all_dups
# setopt hist_ignore_space
# setopt hist_reduce_blanks
# setopt hist_save_no_dups
# setopt inc_append_history

# custom variables
# function __export_date {
#     declare -x DATE="$(date +%Y-%m-%d)"
# }
#
# precmd_functions+=(__export_date)

# direnv
# type direnv > /dev/null 2>&1 && eval "$(direnv hook zsh)"

# GitHub CLI
# type gh > /dev/null 2>&1 && eval "$(gh completion -s zsh)"

# zoxide
# declare -x _ZO_DATA_DIR="${XDG_DATA_HOME}/zoxide"
# type zoxide > /dev/null 2>&1 && eval "$(zoxide init zsh)"

# atuin
# type atuin > /dev/null 2>&1 && eval "$(atuin init zsh --disable-up-arrow --disable-ctrl-r)"
# zle -N _atuin_search
# bindkey -r '^R'
# bindkey '^R' _atuin_search

# alias
## shell
alias -g @i='install'
alias -g @u='uninstall'
alias -g @s='search'
alias -g @latest='"$(command ls -rt $1 | tail -n 1)"'

## docker
alias -g @d_ps='"$(docker ps | tail -n +2 | fzf | awk '"'"'{print $1}'"'"')"'
alias -g @d_ps-a='"$(docker ps -a | tail -n +2 | fzf | awk '"'"'{print $1}'"'"')"'
alias -g @d_image_ls='"$(docker images | tail -n +2 | fzf | awk '"'"'{print $3}'"'"')"'

## mac
if [[ "$(uname)" == 'Darwin' ]]; then
    alias -g @cp='| pbcopy'
    alias -g @pst='"$(pbpaste)"'
    alias -g @icloud='~/Library/Mobile\ Documents/com~apple~CloudDocs'
fi

# completion
type brew > /dev/null 2>&1 && FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select interactive
setopt menu_complete

# keybind
bindkey -e # explicit use emacs keybind
bindkey '^U' backward-kill-line

## cdr
# function __cdr-fzf {
#     declare BUFFER="cd "$(cdr -l | sed 's/^[^ ][^ ]*  *//' | fzf)""
#     zle accept-line
# }
# autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
# add-zsh-hook chpwd chpwd_recent_dirs
# zle -N __cdr-fzf
# bindkey '^J' __cdr-fzf

## command history
# function __history-fzf {
#     declare BUFFER="$(history -n | uniq | fzf)"
#     zle accept-line
# }
# zle -N __history-fzf
# bindkey '^R' __history-fzf

## ghq
function __ghq-fzf {
    declare ROOT="$(ghq root)"
    declare PREVIEW_CMD="eza --tree --git-ignore -I 'node_modules|.git' ${ROOT}/{}"
    declare DEST="${ROOT}/$(ghq list | fzf --preview ${PREVIEW_CMD})"
    declare BUFFER="cd ${DEST}"
    zle accept-line
    mkdir -p "${XDG_STATE_HOME}/ghq"
    echo "$DEST" > "${XDG_STATE_HOME}/ghq/lastdir"
}
zle -N __ghq-fzf
bindkey '^G' __ghq-fzf

alias cdg='cd "$(command cat ${XDG_STATE_HOME}/ghq/lastdir)"'

# syntax highlight
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main line brackets cursor)
declare -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold' # alias
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,bold' # exist path
ZSH_HIGHLIGHT_STYLES[root]='bg=red' # root
