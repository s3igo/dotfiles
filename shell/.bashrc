SHELL_DIR=~/.dotfiles/shell/lib

[ -r $SHELL_DIR/config.sh ] && source $SHELL_DIR/config.sh
[ -r $SHELL_DIR/aliases.sh ] && source $SHELL_DIR/aliases.sh
alias bz='source ~/.bashrc'

# prompt
export PS1='\w\n\$ '

# ----------------------------------- 以降リダイレクトによる追記 ----------------------------------- #
