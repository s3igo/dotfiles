SHELL_DIR=~/.dotfiles/shell/lib

source $SHELL_DIR/config.sh
source $SHELL_DIR/aliases.sh

# alias
alias _start='source ~/.bashrc'

# prompt
function parse-git-branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

local BLUE="\[\e[1;34m\]"
local PURPLE="\[\e[1;35m\]"
local GRAY="n\[\e[1;37m\]"
local WHITE="\[\e[00m\]"

export PS1="\n\w${BLUE} \$(parce-git-branch)${GRAY}\n\$${PURPLE} "
