#!/bin/sh

BASE_DIR=~/.dotfiles/link

# shell
echo "$SHELL" | grep 'zsh' > /dev/null 2>&1 \
	&& ln -fnsv "$BASE_DIR/.zshenv" "$HOME/.zshenv" \
	&& mkdir -p "$HOME/.config/zsh" \
	&& ln -fnsv "$BASE_DIR/.config/zsh/.zshenv" "$HOME/.config/zsh/.zshenv" \
	&& ln -fnsv "$BASE_DIR/.config/zsh/.zshrc" "$HOME/.config/zsh/.zshrc" \

echo "$SHELL" | grep 'bash' > /dev/null 2>&1 \
	&& ln -fnsv "$BASE_DIR/.bashrc" "$HOME/.bashrc" \
	&& ln -fnsv "$BASE_DIR/.bash_profile" "$HOME/.bash_profile"

# vim
ln -fnsv "$BASE_DIR/.vimrc" "$HOME/.vimrc"

# vscode
[ "$(uname)" = 'Darwin' ] \
	&& mkdir -p "$HOME/Library/Application Support/Code/User" \
	&& ln -fnsv "$BASE_DIR/_vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json" \
	&& ln -fnsv "$BASE_DIR/_vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

[ "$(uname)" = 'Linux' ] \
	&& mkdir -p "$HOME/.config/Code/User" \
	&& ln -fnsv "$BASE_DIR/_vscode/keybindings.json" "$HOME/.config/Code/User/settings.json" \
	&& ln -fnsv "$BASE_DIR/_vscode/settings.json" "$HOME/.config/Code/User/settings.json"

# asdf
ln -fnsv "$BASE_DIR/.tool-versions" "$HOME/.tool-versions"

# alacritty
mkdir -p ~/.config/alacritty
ln -fnsv "$BASE_DIR/.config/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"

# git
mkdir -p ~/.config/git
ln -fnsv "$BASE_DIR/.config/git/ignore" "$HOME/.config/git/ignore"
ln -fnsv "$BASE_DIR/.config/git/config" "$HOME/.config/git/config"

# tmux
mkdir -p ~/.config/tmux
ln -fnsv "$BASE_DIR/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

# relogin shell
exec $SHELL -l
