#!/bin/sh

DOT_DIR=~/.dotfiles

ln -fnsv "$DOT_DIR/others/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
ln -fnsv "$DOT_DIR/others/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
ln -fnsv "$DOT_DIR/others/ignore" "$HOME/.config/git/ignore"
ln -fnsv "$DOT_DIR/others/init.el" "$HOME/.emacs.d/init.el"
ln -fnsv "$DOT_DIR/others/init.vim" "$HOME/.config/nvim/init.vim"
[ "$SHELL" = '/bin/zsh' ] && ln -fnsv "$DOT_DIR/shell/.zshrc" "$HOME/.zshrc"
[ "$SHELL" = '/bin/bash' ] && ln -fnsv "$DOT_DIR/shell/.bashrc" "$HOME/.bashrc"
[ "$SHELL" = '/bin/bash' ] && ln -fnsv "$DOT_DIR/shell/.bash_profile" "$HOME/.bash_profile"
ln -fnsv "$DOT_DIR/vim/.vimrc" "$HOME/.vimrc"
# ln -fnsv "$DOT_DIR/.karabiner.json" "$HOME/.config/karabiner/assets/complex_modifications/myKarabiner.json"