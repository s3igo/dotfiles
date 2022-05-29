SHELL_DIR=~/.dotfiles/.shell/shell

[ -r $SHELL_DIR/zinit.sh ] && source $SHELL_DIR/zinit.sh

[ -r $SHELL_DIR/config_common.sh ] && source $SHELL_DIR/config_common.sh
[ -r $SHELL_DIR/aliases_common.sh ] && source $SHELL_DIR/aliases_common.sh


[ -r $SHELL_DIR/config_z.sh ] && source $SHELL_DIR/config_z.sh
[ -r $SHELL_DIR/aliases_z.sh ] && source $SHELL_DIR/aliases_z.sh
[ -r $SHELL_DIR/path.sh ] && source $SHELL_DIR/path.sh

[ -r $SHELL_DIR/lang.sh ] && source $SHELL_DIR/lang.sh
