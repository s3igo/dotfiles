#!/usr/bin/env bash

function shell {
    [[ "$(basename "$FILE")" == .bash* ]] && [[ "$SHELL" == *zsh ]] && return 0
    [[ "$(basename "$FILE")" == .zsh* ]] && [[ "$SHELL" == *bash ]] && return 0

    return 1
}

function inject-op {
    declare FILENAME="$(basename "$FILE")"
    declare TARGET="$(basename "${FILE%/*}")/${FILENAME}"

    [[ "$TARGET" == 'git/config' ]] \
        && echo -n 'op inject: ' \
        && op inject -f -i "$FILE" -o "$DEST" \
        && echo " -> ${FILE}" \
        && return 0

    return 1
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
    [[ "$FILENAME" == karabiner.json ]] \
        && echo -n 'cp: ' \
        && cp -fv "$FILE" "$DEST" \
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

        inject-op && continue
        karabiner && continue

        ln -fnsv "$FILE" "$DEST"
    done < <(find "$LINK_DIR" -mindepth 1 -type f)
    type goku > /dev/null 2>&1 && goku
fi
