#!/bin/bash

source ~/.dotfiles/var.sh

# `uname`によって分岐
function vscode {
    local DIRNAME="$(dirname "$FILE")"
    local MATCH="${DIRNAME##"$(dirname "$DIRNAME")/"}"

    [[ "$MATCH" == '_vscode' ]] || return 1

    if [[ "$(uname)" == 'Darwin' ]]; then
        mkdir -p "$HOME/Library/Application Support/Code/User"
        ln -fnsv "$FILE" "$HOME/Library/Application Support/Code/User/$(basename "$FILE")"
    else
        mkdir -p "$HOME/.config/Code/User"
        ln -fnsv "$FILE" "$HOME/.config/Code/User/$(basename "$FILE")"
    fi

    return 0
}

# `$SHELL`によって分岐
function shell {
    [[ "$FILE" =~ ^\.bash.* ]] \
        && echo "$SHELL" | grep 'zsh' > /dev/null 2>&1 \
        && return 0
    [[ "$FILE" =~ ^\.zsh.* ]] \
        && echo "$SHELL" | grep 'bash' > /dev/null 2>&1 \
        && return 0

    return 1
}

while read -r FILE; do
    vscode && continue
    shell && continue

    DEST="$HOME${FILE##"$LINK_DIR"}"

    mkdir -p "$(dirname "$DEST")"
    ln -fnsv "$FILE" "$DEST"
done < <(find $LINK_DIR -mindepth 1 -type f)

# relogin shell
exec $SHELL -l
