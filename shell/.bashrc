SHELL_DIR=~/.dotfiles/shell/lib

[ -r $SHELL_DIR/config.sh ] && source $SHELL_DIR/config.sh
[ -r $SHELL_DIR/aliases.sh ] && source $SHELL_DIR/aliases.sh
[ "$(uname)" = 'Darwin' ] && [ -r $SHELL_DIR/aliases_mac.sh ] && source $SHELL_DIR/aliases_mac.sh

# alias
alias restart='source ~/.bashrc'

# prompt
export PS1='\n\w\n\$ '
