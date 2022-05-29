#!/bin/sh

if [ "$(uname)" = 'Darwin' ] ; then
	brew bundle ~/.dotfiles/brew/Brewfile
else
	echo 'Not macOS'
fi
