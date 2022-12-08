#!/bin/bash

declare LINK_DIR="${HOME}/.dotfiles/home"

# `uname`によって分岐
function vscode {
    local DIRNAME="$(dirname "$FILE")"

    [[ "$(basename "$DIRNAME")" != '_vscode' ]] && return 1

    if [[ "$(uname)" == 'Darwin' ]]; then
        mkdir -p "${HOME}/Library/Application Support/Code/User"
        ln -fnsv "$FILE" "${HOME}/Library/Application Support/Code/User/$(basename "$FILE")"
    else
        mkdir -p "${HOME}/.config/Code/User"
        ln -fnsv "$FILE" "${HOME}/.config/Code/User/$(basename "$FILE")"
    fi

    return 0
}

# `$SHELL`によって分岐
function shell {
    [[ "$(basename "$FILE")" == .bash* ]] && [[ "$SHELL" == *zsh ]] && return 0

    [[ "$(basename "$FILE")" == .zsh* ]] && [[ "$SHELL" == *bash ]] && return 0

    return 1
}

# make file-based symlink
while read -r FILE; do
    vscode && continue
    shell && continue

    declare DEST="${HOME}${FILE##"$LINK_DIR"}"

    mkdir -p "$(dirname "$DEST")"
    ln -fnsv "$FILE" "$DEST"
done < <(find "$LINK_DIR" -mindepth 1 -type f)

# relogin shell
exec $SHELL -l
