#!/bin/zsh

source ~/.dotfiles/var.sh

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

# zinit
source "$SHELL_DIR/zinit.sh"
type zinit > /dev/null 2>&1 \
    && echo '--- update zinit ---' \
    && zinit update --all

# asdf
type asdf > /dev/null 2>&1 \
    && echo '--- update asdf ---' \
    && asdf plugin-update --all
