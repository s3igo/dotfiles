#!/bin/bash

declare LINK_DIR="${HOME}/.dotfiles/home"

function shell {
    [[ "$(basename "$FILE")" == .bash* ]] && [[ "$SHELL" == *zsh ]] && return 0

    [[ "$(basename "$FILE")" == .zsh* ]] && [[ "$SHELL" == *bash ]] && return 0

    return 1
}

# make file-based symlink
while read -r FILE; do
    shell && continue

    declare DEST="${HOME}${FILE##"$LINK_DIR"}"

    mkdir -p "$(dirname "$DEST")"
    ln -fnsv "$FILE" "$DEST"
done < <(find "$LINK_DIR" -mindepth 1 -type f)

# relogin shell
exec $SHELL -l
