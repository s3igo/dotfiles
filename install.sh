#!/bin/bash


# # ---------------------------------- init.sh --------------------------------- #

source ./bin/init.sh
# # install Xcode-CLI
# [ "$(uname)" = 'Darwin' ] \
# 	&& which xcode-select > /dev/null 2>&1 \
# 	|| xcode-select --install

# # install brew
# which brew > /dev/null 2>&1 \
# 	|| /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
# 	&& [ "$(uname -m)" = 'arm64' ] \
# 	&& eval "$(/opt/homebrew/bin/brew shellenv)"

# # brew update
# which brew > /dev/null 2>&1 && brew update

# # install git
# which git > /dev/null 2>&1 || brew install git

# # ---------------------------------------------------------------------------- #

# # clone dotfiles
git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles

# # ---------------------------------- link.sh --------------------------------- #

source ./bin/link.sh
# DOT_DIR=~/.dotfiles

# # shell
# [ "$SHELL" = '/bin/zsh' ] \
# 	&& ln -fnsv "$DOT_DIR/shell/.zshrc" "$HOME/.zshrc" \
# 	&& [ -f "$HOME/.bashrc" -a -f "$HOME/.bash_profile" ] \
# 	&& rm -f "$HOME/.bashrc" "$HOME/.bash_profile"

# [ "$SHELL" = '/bin/bash' ] \
# 	&& ln -fnsv "$DOT_DIR/shell/.bashrc" "$HOME/.bashrc" \
# 	&& ln -fnsv "$DOT_DIR/shell/.bash_profile" "$HOME/.bash_profile" \
# 	&& [ -f "$HOME/.zshrc" ] \
# 	&& rm -f "$HOME/.zshrc"

# # vim
# ln -fnsv "$DOT_DIR/vim/.vimrc" "$HOME/.vimrc"

# # global-gitignore
# mkdir -p ~/.config/git
# ln -fnsv "$DOT_DIR/others/.gitignore_global" "$HOME/.config/git/ignore"

# # relogin shell
# exec $SHELL -l

# # ---------------------------------------------------------------------------- #

# # TODO
# # git config --global user.nameとuser.emailも.envから呼んで設定できるといいかも
# # install.shをファイル分割しても正しく動作するかどうか確認
