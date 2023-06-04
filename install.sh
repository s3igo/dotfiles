#!/bin/bash

# ./bin/init.sh
eval "$(curl -fsSL raw.githubusercontent.com/s3igo/dotfiles/main/bin/init.sh)"

# clone dotfiles
git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles

# ./bin/link.sh
eval "$(curl -fsSL raw.githubusercontent.com/s3igo/dotfiles/main/bin/link.sh)"

# restart shell
exec $SHELL -l
