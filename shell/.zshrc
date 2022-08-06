SHELL_DIR=~/.dotfiles/shell/lib

source $SHELL_DIR/zinit.sh
source $SHELL_DIR/config.sh
source $SHELL_DIR/aliases.sh
source $SHELL_DIR/aliases_z.sh

# auto correct
setopt CORRECT_ALL

# beep
unsetopt BEEP

# history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
