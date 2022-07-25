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
