#!/bin/bash

# ./bin/init.sh
bash -c "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/bin/init.sh)"

# clone dotfiles
git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles

# make tool
make -C ~/.dotfiles tool

# ./bin/link.sh
bash -c "$(curl -L raw.githubusercontent.com/s3igo/dotfiles/main/bin/link.sh)"
