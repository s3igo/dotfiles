#!/bin/bash

# brew
which brew > /dev/null 2>&1 \
    && echo '--- update homebrew ---' \
    && brew update \
    && brew upgrade \
    && brew cleanup

# mas-cli
which mas > /dev/null 2>&1 \
    && echo '--- update mas-cli ---' \
    && mas upgrade

# TODO: 謎に`--- update zinit ---`が実行されない
# zinit
which zinit > /dev/null 2>&1 \
    && echo '--- update zinit ---' \
    && zinit update --all \
    && echo 'y' | zinit delete --clean

# asdf
which asdf > /dev/null 2>&1 \
    && echo '--- update asdf ---' \
    && asdf plugin-update --all
