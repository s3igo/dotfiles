SHELL_DIR=~/.dotfiles/shell/lib

[ -r $SHELL_DIR/config.sh ] && source $SHELL_DIR/config.sh
[ -r $SHELL_DIR/aliases.sh ] && source $SHELL_DIR/aliases.sh

# prompt
export PS1='\w\n\$ '
