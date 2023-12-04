#!/usr/bin/env bash

# make file-based symlink
declare LINK_DIR="${HOME}/.dotfiles/config/home"
while read -r FILE; do
    # $TARGET can be used in a naive way: `ln -s $FILE $TARGET`
    declare TARGET="${HOME}${FILE#"$LINK_DIR"}"

    declare INIT="$(dirname "$TARGET")"
    declare LAST="$(basename "$TARGET")"

    if [[ "$LAST" == '[mac]'* ]] && [[ "$(uname)" == 'Darwin' ]]; then
        mkdir -p "$INIT"
        ln -fnsv "$FILE" "${INIT}/${LAST#'[mac]'}"
        continue
    elif [[ "$LAST" == '[linux]'* ]] && [[ "$(uname)" == 'Linux' ]]; then
        mkdir -p "$INIT"
        ln -fnsv "$FILE" "${INIT}/${LAST#'[linux]'}"
        continue
    fi

    mkdir -p "$INIT"
    ln -fnsv "$FILE" "$TARGET"
done < <(find "$LINK_DIR" -mindepth 1 -type f)

# hooks
function karabiner {
    declare TARGET="${XDG_CONFIG_HOME}/karabiner/karabiner.json"
    mkdir -p "$(dirname "$TARGET")"
    echo -n 'cp: ' && cp -fv "${LINK_DIR}/${FILE}" "$TARGET"
}

# custom link
LINK_DIR="${HOME}/.dotfiles/config/custom"
while read -r FILE; do
    # call hook
    "${FILE%.*}"
done < <(command ls -1A "$LINK_DIR")

# post link process
[[ "$(uname)" == 'Darwin' ]] && type goku > /dev/null 2>&1 && goku

exit 0
