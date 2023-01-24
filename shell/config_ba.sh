# color
declare -x LS_COLORS='di=34:ex=31:fi=37:ln=35'

# history
declare -x HISTFILE="${XDG_STATE_HOME}/bash_history"

# prompt
function __prompt-command {
    local EXIT_STATUS="$?"

    local RED='\[\e[0;31m\]'
    local BLUE='\[\e[0;34m\]'
    local PURPLE='\[\e[0;35m\]'
    local WHITE='\[\e[0;37m\]'
    local GRAY='\[\e[1;30m\]'

    # branch
    local BRANCH=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'`

    # exit status
    local STATUS="$PURPLE"
    [[ "$EXIT_STATUS" == 0 ]] || STATUS="$RED"

    # character
    local CHAR='\$'
    [[ "$UID" == 0 ]] && CHAR='#'

    PS1="\n${BLUE}\w${GRAY}${BRANCH}\n${STATUS}${CHAR}${WHITE} "
}

declare -x PROMPT_COMMAND=__prompt-command

# GitHub CLI
type gh > /dev/null 2>&1 && eval "$(gh completion -s bash)"
