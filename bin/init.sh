#!/bin/bash

# set Homebrew
if [[ "$(uname)" == 'Darwin' ]]; then
     type xcode-select > /dev/null 2>&1 || xcode-select --install
     type brew > /dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# xdg-based directories
mkdir -p ~/{.config,.cache}
mkdir -p ~/.local/{share,state}
