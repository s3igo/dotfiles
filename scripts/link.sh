#!/usr/bin/env bash

function shell {
    [[ "$(basename "$FILE")" == .bash* ]] && [[ "$SHELL" == *zsh ]] && return 0
    [[ "$(basename "$FILE")" == .zsh* ]] && [[ "$SHELL" == *bash ]] && return 0

    return 1
}

function inject-op {
    declare FILENAME="$(basename "$FILE")"
    declare DIRNAME="$(dirname "$FILE")"
    declare NAME="${FILENAME%.*}"
    declare EXT="${FILENAME##*.}"
    declare TARGET="$(dirname "$DEST")/${NAME}"

    [[ "$EXT" == 'op' ]] \
        && echo -n 'op inject: ' \
        && op inject -f -i "$FILE" -o "$TARGET" \
        && echo " -> ${FILE}" \
        && return 0
}

# make file-based symlink
echo '--- common config ---'
declare LINK_DIR="${HOME}/.dotfiles/config/common/HOME"
while read -r FILE; do
    declare DEST="${HOME}${FILE##"$LINK_DIR"}"
    mkdir -p "$(dirname "$DEST")"

    shell && continue
    inject-op && continue

    ln -fnsv "$FILE" "$DEST"
done < <(find "$LINK_DIR" -mindepth 1 -type f)

# if macOS
function karabiner {
    [[ "$(basename "$FILE")" == karabiner.json ]] \
        && echo -n 'cp: ' \
        && cp -fv "$FILE" "$DEST" \
        && return 0
}

echo -e '\n--- MacOS specific config ---'
if [[ "$(uname)" == 'Darwin' ]]; then
    declare LINK_DIR="${HOME}/.dotfiles/config/mac/HOME"
    while read -r FILE; do
        declare DEST="${HOME}${FILE##"$LINK_DIR"}"
        mkdir -p "$(dirname "$DEST")"

        inject-op && continue
        karabiner && continue

        ln -fnsv "$FILE" "$DEST"
    done < <(find "$LINK_DIR" -mindepth 1 -type f)
    type goku > /dev/null 2>&1 && goku
fi
