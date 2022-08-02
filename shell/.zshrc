SHELL_DIR=~/.dotfiles/shell/lib

# zinit
[ -r $SHELL_DIR/zinit.sh ] && source $SHELL_DIR/zinit.sh

[ -r $SHELL_DIR/config.sh ] && source $SHELL_DIR/config.sh
[ -r $SHELL_DIR/aliases.sh ] && source $SHELL_DIR/aliases.sh
[ -r $SHELL_DIR/aliases_z.sh ] && source $SHELL_DIR/aliases_z.sh
[ "$(uname)" = 'Darwin' ] && [ -r $SHELL_DIR/aliases_mac.sh ] && source $SHELL_DIR/aliases_mac.sh
