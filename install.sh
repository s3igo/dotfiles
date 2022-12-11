#!/bin/bash

# ./bin/init.sh
eval "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/bin/init.sh)"

# clone dotfiles
git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles

# ./bin/link.sh
eval "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/bin/link.sh)"
