#!/bin/bash

echo "$SHELL" | grep 'bash' > /dev/null 2>&1 \
	&& ln -fnsv ~/.dotfiles/shell/.bashrc ~/.bashrc \
	&& ln -fnsv ~/.dotfiles/shell/.bash_profile ~/.bash_profile

echo "$SHELL" | grep 'zsh' > /dev/null 2>&1 && ln -fnsv ~/.dotfiles/shell/.zshrc ~/.zshrc

ln -fnsv ~/.dotfiles/vim/.vimrc ~/.vimrc
