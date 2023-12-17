bindkey '^U' backward-kill-line

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
