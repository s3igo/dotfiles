#!/bin/bash

[[ "$SHELL" == *bash ]] \
    && ln -fnsv ~/.dotfiles/link/.bashrc ~/.bashrc \
    && ln -fnsv ~/.dotfiles/link/.bash_profile ~/.bash_profile

ln -fnsv ~/.dotfiles/link/.vimrc ~/.vimrc
