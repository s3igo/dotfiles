#!/bin/bash

function shell {
    [[ "$(basename "$FILE")" == .bash* ]] && [[ "$SHELL" == *zsh ]] && return 0
    [[ "$(basename "$FILE")" == .zsh* ]] && [[ "$SHELL" == *bash ]] && return 0

    return 1
}

# make file-based symlink
echo '--- common config ---'
declare LINK_DIR="${HOME}/.dotfiles/config/common/HOME"
while read -r FILE; do
    shell && continue

    declare DEST="${HOME}${FILE##"$LINK_DIR"}"

    mkdir -p "$(dirname "$DEST")"
    ln -fnsv "$FILE" "$DEST"
done < <(find "$LINK_DIR" -mindepth 1 -type f)

# if macOS
echo -e '\n--- MacOS specific config ---'
if [[ "$(uname)" == 'Darwin' ]]; then
    declare LINK_DIR="${HOME}/.dotfiles/config/mac/HOME"
    while read -r FILE; do
        declare DEST="${HOME}${FILE##"$LINK_DIR"}"

        mkdir -p "$(dirname "$DEST")"
        ln -fnsv "$FILE" "$DEST"
    done < <(find "$LINK_DIR" -mindepth 1 -type f)
fi
