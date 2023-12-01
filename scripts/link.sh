#!/usr/bin/env bash

# hooks
function karabiner {
    mkdir -p "$INIT"
    echo -n 'cp: ' && cp -fv "$FILE" "${INIT}/karabiner.json"
}

# make file-based symlink
declare LINK_DIR="${HOME}/.dotfiles/config/home"
while read -r FILE; do
    # $TARGET can be used in a naive way; `ln -s $FILE $TARGET`
    declare TARGET="${HOME}${FILE#"$LINK_DIR"}"

    declare INIT="$(dirname "$TARGET")"
    declare LAST="$(basename "$TARGET")"

    if [[ "$LAST" == '[hook]'* ]]; then
        # remove extension
        declare FILENAME="${LAST%.*}"
        # call hook
        ${FILENAME#'[hook]'}
        continue
    fi

    if [[ "$(uname)" == 'Darwin' ]]; then
        mkdir -p "$INIT"
        ln -fnsv "$FILE" "${INIT}/${LAST#'[mac]'}"
    elif [[ "$(uname)" == 'Linux' ]]; then
        mkdir -p "$INIT"
        ln -fnsv "$FILE" "${INIT}/${LAST#'[linux]'}"
    fi
done < <(find "$LINK_DIR" -mindepth 1 -type f)

# post link process
[[ "$(uname)" == 'Darwin' ]] && type goku > /dev/null 2>&1 && goku

exit 0
