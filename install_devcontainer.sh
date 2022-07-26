#!/bin/bash

[ "$SHELL" = '/bin/bash' ] \
	&& ln -fnsv ~/.dotfiles/shell/.bashrc ~/.bashrc \
	&& ln -fnsv ~/.dotfiles/shell/.bash_profile ~/.bash_profile

[ "$SHELL" = '/bin/zsh' ] && ln -fnsv ~/.dotfiles/shell/.zshrc ~/.zshrc

ln -fnsv ~/.dotfiles/vim/.vimrc ~/.vimrc
