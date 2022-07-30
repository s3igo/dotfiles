#!/bin/sh

DOT_DIR=~/.dotfiles

# shell
echo "$SHELL" | grep 'zsh' > /dev/null 2>&1 \
	&& ln -fnsv "$DOT_DIR/shell/.zshrc" "$HOME/.zshrc" \
	&& [ -f "$HOME/.bashrc" -a -f "$HOME/.bash_profile" ] \
	&& rm -f "$HOME/.bashrc" "$HOME/.bash_profile"

echo "$SHELL" | grep 'bash' > /dev/null 2>&1 \
	&& ln -fnsv "$DOT_DIR/shell/.bashrc" "$HOME/.bashrc" \
	&& ln -fnsv "$DOT_DIR/shell/.bash_profile" "$HOME/.bash_profile" \
	&& [ -f "$HOME/.zshrc" ] \
	&& rm -f "$HOME/.zshrc"

# vim
ln -fnsv "$DOT_DIR/vim/.vimrc" "$HOME/.vimrc"

# vscode
[ "$(uname)" = 'Darwin' ] \
	&& mkdir -p "$HOME/Library/Application Support/Code/User/keybindings.json" \
	&& ln -fnsv "$DOT_DIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json" \
	&& ln -fnsv "$DOT_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

[ "$(uname)" = 'Linux' ] \
	&& mkdir -p "$HOME/.config/Code/User/settings.json" \
	&& ln -fnsv "$DOT_DIR/vscode/keybindings.json" "$HOME/.config/Code/User/settings.json" \
	&& ln -fnsv "$DOT_DIR/vscode/settings.json" "$HOME/.config/Code/User/settings.json"

# asdf
ln -fnsv "$DOT_DIR/others/.tool-versions" "$HOME/.tool-versions"

# global-gitignore
mkdir -p ~/.config/git
ln -fnsv "$DOT_DIR/others/.gitignore_global" "$HOME/.config/git/ignore"

# relogin shell
exec $SHELL -l
