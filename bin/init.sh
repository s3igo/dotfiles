#!/bin/sh

if [ "$uname" = 'Darwin' ] ; then
	xcode-select --install > /dev/null
	/bin/zsh -c "$curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" > /dev/null
else
	echo 'not MacOS'
fi