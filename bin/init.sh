#!/bin/bash

# set package manager
if [[ "$(uname)" == 'Darwin' ]]; then
     type xcode-select > /dev/null 2>&1 || xcode-select --install
     type brew > /dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     [[ "$(uname -m)" == 'arm64' ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# default xdg-based directories
mkdir -p ~/{.config,.cache}
mkdir -p ~/.local/{share,state}
