#!/usr/bin/env bash

# scripts/init.sh
eval "$(curl -fsSL raw.githubusercontent.com/s3igo/dotfiles/main/scripts/init.sh)"

# clone dotfiles
git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles

# scripts/link.sh
eval "$(curl -fsSL raw.githubusercontent.com/s3igo/dotfiles/main/scripts/link.sh)"
