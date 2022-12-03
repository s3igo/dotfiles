#!/bin/bash

[[ "$SHELL" == *bash ]] \
    && ln -fnsv ~/.dotfiles/home/.bashrc ~/.bashrc \
    && ln -fnsv ~/.dotfiles/home/.bash_profile ~/.bash_profile

ln -fnsv ~/.dotfiles/home/.vimrc ~/.vimrc
