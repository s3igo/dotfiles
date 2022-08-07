#!/bin/bash

echo "$SHELL" | grep 'bash' > /dev/null 2>&1 \
    && ln -fnsv ~/.dotfiles/link/.bashrc ~/.bashrc \
    && ln -fnsv ~/.dotfiles/link/.bash_profile ~/.bash_profile

ln -fnsv ~/.dotfiles/link/.vimrc ~/.vimrc
