#!/usr/bin/env bash

# make file-based symlink
echo '--- common config ---'
declare LINK_DIR="${HOME}/.dotfiles/config/common/HOME"
while read -r FILE; do
    declare DEST="${HOME}${FILE##"$LINK_DIR"}"
    mkdir -p "$(dirname "$DEST")"


    ln -fnsv "$FILE" "$DEST"
done < <(find "$LINK_DIR" -mindepth 1 -type f)

# if macOS
function karabiner {
    [[ "$FILENAME" == karabiner.json ]] \
        && echo -n 'cp: ' \
        && cp -fv "$FILE" "$DEST" \
        && goku \
        && return 0

    return 1
}

if [[ "$(uname)" == 'Darwin' ]]; then
    echo -e '\n--- MacOS specific config ---'
    declare LINK_DIR="${HOME}/.dotfiles/config/mac/HOME"
    while read -r FILE; do
        declare DEST="${HOME}${FILE##"$LINK_DIR"}"
        mkdir -p "$(dirname "$DEST")"

        declare FILENAME="$(basename "$FILE")"

        karabiner && continue

        ln -fnsv "$FILE" "$DEST"
    done < <(find "$LINK_DIR" -mindepth 1 -type f)
fi
