#!/bin/sh

# import $GLOBAL_NODE_VERSION
. ./.env

# install nodenv
which nodenv > /dev/null 2>&1 || brew install nodenv

# initialize
eval "$(nodenv init -)"
export PATH="$PATH:$HOME/.nodenv/bin"

# install node & set global version & enable yarn (>16.9)
eval "nodenv install $GLOBAL_NODE_VERSION" \
	&& nodenv rehash \
	&& eval "nodenv global $GLOBAL_NODE_VERSION" \
	&& which yarn > /dev/null 2>&1 \
	|| corepack enable yarn \
	&& nodenv rehash
