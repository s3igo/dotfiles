SHELL_DIR=~/.dotfiles/shell/lib

source $SHELL_DIR/config.sh
source $SHELL_DIR/aliases.sh

# alias
alias _start='source ~/.bashrc'

# prompt
function parse-git-branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

BLUE="\[\e[1;34m\]"
PURPLE="\[\e[1;35m\]"
GRAY="n\[\e[1;37m\]"
WHITE="\[\e[00m\]"

export PS1="\n${BLUE}\w ${GRAY}\$(parse-git-branch)\n${PURPLE}\$${WHITE} "
