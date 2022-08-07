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

# brew update & upgrade
which brew > /dev/null 2>&1 \
    && brew update \
    && brew upgrade

# install git
which git > /dev/null 2>&1 || brew install git

# install make
which make > /dev/null 2>&1 || brew install make

if [ "$SHELL" != '/bin/zsh' ]; then
    # install zsh
    which zsh > /dev/null 2>&1 \
        || brew install zsh \
        && which zsh >> /etc/shells

    # change shell to zsh
    chsh -s `which zsh`
fi
