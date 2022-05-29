SHELL_DIR=~/.dotfiles/shell/lib

# zinit
[ -r $SHELL_DIR/zinit.sh ] && source $SHELL_DIR/zinit.sh

# common
[ -r $SHELL_DIR/config.sh ] && source $SHELL_DIR/config.sh
[ -r $SHELL_DIR/aliases.sh ] && source $SHELL_DIR/aliases.sh

# zsh
[ -r $SHELL_DIR/config_z.sh ] && source $SHELL_DIR/config_z.sh
[ -r $SHELL_DIR/aliases_z.sh ] && source $SHELL_DIR/aliases_z.sh
[ -r $SHELL_DIR/path.sh ] && source $SHELL_DIR/path.sh

# ----------------------------------- 以降リダイレクトによる追記 ----------------------------------- #

[ -r $SHELL_DIR/lang.sh ] && source $SHELL_DIR/lang.sh
