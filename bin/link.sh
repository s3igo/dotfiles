#!/bin/sh

DOT_DIR=~/.dotfiles

[ "$SHELL" = '/bin/zsh' ] && ln -fnsv "$DOT_DIR/shell/.zshrc" "$HOME/.zshrc"
[ "$SHELL" = '/bin/bash' ] && ln -fnsv "$DOT_DIR/shell/.bashrc" "$HOME/.bashrc"
[ "$SHELL" = '/bin/bash' ] && ln -fnsv "$DOT_DIR/shell/.bash_profile" "$HOME/.bash_profile"

ln -fnsv "$DOT_DIR/vim/.vimrc" "$HOME/.vimrc"
ln -fnsv "$DOT_DIR/others/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -fnsv "$DOT_DIR/others/gitignore_global" "$HOME/.config/git/ignore"