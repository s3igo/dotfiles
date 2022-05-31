#!/bin/bash


# ---------------------------------- init.sh --------------------------------- #

# install Xcode-CLI
[ "$(uname)" = 'Darwin' ] \
	&& which xcode-select > /dev/null 2>&1 \
	|| xcode-select --install

# install brew
which brew > /dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew update
which brew > /dev/null 2>&1 && brew update

# install git
which git > /dev/null 2>&1 || brew install git

# ---------------------------------------------------------------------------- #

# clone dotfiles
git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles

# ---------------------------------- link.sh --------------------------------- #

DOT_DIR=~/.dotfiles

# shell
[ "$SHELL" = '/bin/zsh' ] \
	&& ln -fnsv "$DOT_DIR/shell/.zshrc" "$HOME/.zshrc" \
	&& [ -f "$HOME/.bashrc" -a -f "$HOME/.bash_profile" ] \
	&& rm -f "$HOME/.bashrc" "$HOME/.bash_profile"

[ "$SHELL" = '/bin/bash' ] \
	&& ln -fnsv "$DOT_DIR/shell/.bashrc" "$HOME/.bashrc" \
	&& ln -fnsv "$DOT_DIR/shell/.bash_profile" "$HOME/.bash_profile" \
	&& [ -f "$HOME/.zshrc" ] \
	&& rm -f "$HOME/.zshrc"

# vim
ln -fnsv "$DOT_DIR/vim/.vimrc" "$HOME/.vimrc"

# global-gitignore
ln -fnsv "$DOT_DIR/others/.gitignore_global" "$HOME/.config/git/ignore"

[ "$SHELL" = '/bin/zsh' ] && source ~/.zshrc
[ "$SHELL" = '/bin/bash' ] && source ~/.bashrc

# ---------------------------------------------------------------------------- #

cd ~/.dotfiles
