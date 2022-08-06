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
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

function zshaddhistory() {
    local LINE=${1%%$'\n'}
    local CMD=${LINE%% *}

    [[ ${#LINE} -ge 5
        && ${CMD} != (l[sal])
        && ${CMD} != 'cd'
        && ${CMD} != 'rip'
    ]]
}

function __update_history() {
    local EXIT_STATUS="$?"

    fc -W
    if [[ ${EXIT_STATUS} != 0 ]]; then
        ed -s ~/.config/zsh/.zsh_history <<EOF >/dev/null
d
w
q
EOF
    fi
}

precmd_functions+=(__update_history)
