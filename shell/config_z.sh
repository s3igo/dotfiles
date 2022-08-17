# auto correct
setopt CORRECT

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

    [[ ${CMD} != (l[sal])
        && ${CMD} != 'cd'
        && ${CMD} != 'rip'
    ]]
}

function __update_history() {
    local EXIT_STATUS="$?"

    fc -W
    if [[ ${EXIT_STATUS} != 0 ]]; then
        ed -s "$HISTFILE" <<EOF >/dev/null
d
w
q
EOF
    fi
}

precmd_functions+=(__update_history)
