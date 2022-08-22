#!/bin/zsh

source ~/.dotfiles/var.sh

# brew
which brew > /dev/null 2>&1 \
    && echo "\n--- update homebrew ---" \
    && brew update \
    && brew upgrade \
    && brew cleanup

# mas-cli
which mas > /dev/null 2>&1 \
    && echo "\n--- update mas-cli ---" \
    && mas upgrade

# zinit
source "$SHELL_DIR/zinit.sh"
type zinit > /dev/null 2>&1 \
    && echo "\n--- update zinit ---" \
    && zinit update --all

# asdf
type asdf > /dev/null 2>&1 \
    && echo "\n--- update asdf ---" \
    && asdf plugin-update --all
