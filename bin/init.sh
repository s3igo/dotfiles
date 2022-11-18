#!/bin/bash

# set package manager
if [[ "$(uname)" == 'Darwin' ]]; then
     type xcode-select > /dev/null 2>&1 || xcode-select --install
     type brew > /dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     [[ "$(uname -m)" == 'arm64' ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi


# init package manager
if type brew > /dev/null 2>&1; then
    sudo brew update && sudo brew upgrade
elif type apt > /dev/null 2>&1; then
    sudo apt update && sudo apt upgrade
elif type yum > /dev/null 2>&1; then
    sudo yum update && sudo yum upgrade
else
    echo 'unknown package manager'
    exit 1
fi

# init zsh 
# NOTE: mutable operation
[[ "$SHELL" == *zsh ]] && echo 'export ZDOTDIR="${HOME}/.config/zsh"' | sudo tee -a /etc/zshenv

# default xdg-based directories
mkdir -p ~/{.config,.cache}
mkdir -p ~/.local/{share,state}
