#!/bin/bash

BASE_DIR="$HOME/.dotfiles/link"

function vscode() {
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

while read -r FILE; do
    DIRNAME="$(dirname "$FILE")"
    # ディレクトリ名を抽出
    MATCH="${DIRNAME##"$(dirname "$DIRNAME")/"}"

    # vscodeは`uname`によって分岐
    vscode && continue

    # ./linkを$HOMEに置換
    DEST="$HOME${FILE##"$BASE_DIR"}"

    mkdir -p "$(dirname "$DEST")"
    ln -fnsv "$FILE" "$DEST"
done < <(find $BASE_DIR -mindepth 1 -type f)

# relogin shell
exec $SHELL -l
