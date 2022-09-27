#!/bin/bash

# install dependencies
[[ "$(uname)" == 'Darwin' ]] \
    && type xcode-select > /dev/null 2>&1 \
    || xcode-select --install
if [[ "$(uname)" == 'Linux' ]]; then
    if type apt > /dev/null 2>&1; then
        sudo apt -y update
        sudo apt -y upgrade
        sudo apt -y autoremove
        sudo apt -y install build-essential
    else
        sudo yum -y update
        sudo yum -y upgrade
        sudo yum -y groupinstall 'Development Tools'
    fi
fi

# install brew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
[[ "$(uname)" == 'Darwin' ]] && [[ "$(uname -m)" == 'arm64' ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ "$(uname)" == 'Linux' ]] && eval "$($HOME/.linuxbrew/bin/brew shellenv)"

# install git & make
type git > /dev/null 2>&1 || brew install git
type make > /dev/null 2>&1 || brew install make

if [[ "$SHELL" != *zsh ]]; then
    # install zsh
    type zsh > /dev/null 2>&1 \
        || brew install zsh \
        && which zsh >> /etc/shells

    # change shell to zsh
    chsh -s `which zsh`
fi

# init zsh
echo 'export ZDOTDIR="${HOME}/.config/zsh"' | sudo tee -a /etc/zshenv

# make default xdg directories
mkdir -p ~/{.config,.cache}
mkdir -p ~/.local/{share,state}
