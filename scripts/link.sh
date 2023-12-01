#!/usr/bin/env bash

function link {
    mkdir -p "$(dirname "$2")"
    ln -fnsv "$1" "$2"
}

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

    [[ "$(uname)" == 'Darwin' ]] && link "$FILE" "${INIT}/${LAST#'[mac]'}"
    [[ "$(uname)" == 'Linux' ]] && link "$FILE" "${INIT}/${LAST#'[linux]'}"
done < <(find "$LINK_DIR" -mindepth 1 -type f)

# post link process
[[ "$(uname)" == 'Darwin' ]] && type goku > /dev/null 2>&1 && goku

exit 0
