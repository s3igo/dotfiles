#!/bin/sh

# install anyenv
brew install anyenv

# "$ anyenv update" to update OOenv
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

# yarn install automatically
anyenv install nodenv
mkdir -p $(nodenv root)/plugins
git clone https://github.com/pine/nodenv-yarn-install.git $(nodenv root)/plugins/nodenv-yarn-install
