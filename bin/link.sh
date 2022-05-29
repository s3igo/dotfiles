#!/bin/sh

DOT_DIR=~/.dotfiles

# to use process substitution
# set +o posix

# files in ~/.dotfiles/.ANY_DIR/ exclude *.git and .DS_Store
while read -r dotfile; do
	# make symlink at $HOME/Library/Application Support/Code/User/
	[ $(dirname "$dotfile") = "$DOT_DIR/.code" ] \
		&& ln -fnsv "$dotfile" "$HOME/Library/Application Support/Code/User/$(basename "$dotfile")" \
		&& continue

	# make symlink at $HOME/.config/git/
	[ $(basename "$dotfile") = 'ignore' ] \
		&& ln -fnsv "$dotfile" "$HOME/.config/git/ignore" \
		&& continue

	# make symlink at $HOME/.emacs.d/
	[ $(basename "$dotfile") = 'init.el' ] \
		&& ln -fnsv "$dotfile" "$HOME/.emacs.d/init.el" \
		&& continue

	# make symlink at $HOME/.config/nvim/init.vim
	[ $(basename "$dotfile") = 'init.vim' ] \
		&& ln -fnsv "$dotfile" "$HOME/.config/nvim/init.vim" \
		&& continue

	# make symlink at $HOME/.config/karabiner/assets/complex_modifications
	[ $(basename "$dotfile") = 'karabiner.json' ] \
		&& ln -fnsv "$dotfile" "$HOME/.config/karabiner/assets/complex_modifications/myKarabiner.json" \
		&& continue

	# make symlink at $HOME
	ln -fnsv "$dotfile" "$HOME"
done < <(find $DOT_DIR/\.??* \
	-type d -name '.vscode' -prune \
	-o -type f -mindepth 1 -maxdepth 1 \
	-not -name '*.git' -not -name '.DS_Store')