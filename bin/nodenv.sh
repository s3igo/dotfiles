#!/bin/sh

GLOBAL_NODE_VERSION=18.6.0
# TODO: GLOBAL_NODE_VERSIONを.envから読めるようにしたい

# install nodenv
which nodenv > /dev/null 2>&1 || brew install nodenv

# initialize
eval "$(nodenv init -)"
export PATH="$PATH:$HOME/.nodenv/bin"

# install node
eval "nodenv install $GLOBAL_NODE_VERSION" && nodenv rehash

# set global version
eval "nodenv global $GLOBAL_NODE_VERSION"

# enable yarn (>16.9)
which yarn > /dev/null 2>&1 || corepack enable yarn && nodenv rehash