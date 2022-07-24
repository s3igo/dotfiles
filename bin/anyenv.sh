#!/bin/sh

# install anyenv
brew install anyenv

# "$ anyenv update" to update OOenv
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

# TODO: 以下いらないかも
# $ corepack enable yarn
# $ nodenv rehash
# で事足りる気がする
# ref: https://qiita.com/takkeybook/items/4e73449488a306b032c9

# yarn install automatically
anyenv install nodenv
mkdir -p $(nodenv root)/plugins
git clone https://github.com/pine/nodenv-yarn-install.git $(nodenv root)/plugins/nodenv-yarn-install
