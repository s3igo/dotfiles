#!/bin/sh

# install Xcode-CLI
[ "$(uname)" = 'Darwin' ] \
	&& which xcode-select > /dev/null 2>&1 \
	|| xcode-select --install

# install brew
which brew > /dev/null 2>&1 \
	|| /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
	&& [ "$(uname -m)" = 'arm64' ] \
	&& eval "$(/opt/homebrew/bin/brew shellenv)"

# brew update
which brew > /dev/null 2>&1 && brew update

# install git
which git > /dev/null 2>&1 || brew install git

# install make
which make > /dev/null 2>&1 || brew install make

# change shell to zsh
[ "$SHELL" != '/bin/zsh' ] && if which zsh > /dev/null 2>&1; then
	chsh -s `which zsh`
else
	brew install zsh
	which zsh >> /etc/shells
	chsh -s `which zsh`
fi
