#!/bin/bash

# install dependencies
[ "$(uname)" = 'Darwin' ] \
    && which xcode-select > /dev/null 2>&1 \
    || xcode-select --install
if [ "$(uname)" = 'Linux' ]; then
    which apt 2>&1 /dev/null
    if [ $? -eq 0 ]; then
        sudo apt -y update
        sudo apt -y upgrade
        sudo apt -y autoremove
        sudo apt -y install build-essential
    else
        sudo yum -y update
        sudo yum -y upgrade
        sudo yum -y groupinstall "Development Tools"
    fi
fi

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
[ "$(uname)" = 'Darwin' ] && [ "$(uname -m)" = 'arm64' ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ "$(uname)" = 'Linux' ] && eval "$($HOME/.linuxbrew/bin/brew shellenv)"

brew update && brew upgrade

# install git & make
which git > /dev/null 2>&1 || brew install git
which make > /dev/null 2>&1 || brew install make

if [ "$SHELL" != '/bin/zsh' ]; then
    # install zsh
    which zsh > /dev/null 2>&1 \
        || brew install zsh \
        && which zsh >> /etc/shells

    # change shell to zsh
    chsh -s `which zsh`
fi
