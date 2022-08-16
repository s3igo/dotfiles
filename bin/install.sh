#!/bin/bash

# ./bin/init.sh
bash -c "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/bin/init.sh)"

# brew path
[ "$(uname)" = 'Darwin' ] && [ "$(uname -m)" = 'arm64' ] && eval "$(/opt/homebrew/bin/brew shellenv)"
[ "$(uname)" = 'Linux' ] && eval "$($HOME/.linuxbrew/bin/brew shellenv)"

# clone dotfiles
git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles

# make tool
make -C ~/.dotfiles tool

# ./bin/link.sh
bash -c "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/bin/link.sh)"
