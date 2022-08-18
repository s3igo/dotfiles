# alias
alias _start='source ~/.bashrc'

# color
export LS_COLORS='di=34:ex=31:fi=37:ln=35'

# prompt
function __prompt-command {
    local EXIT_STATUS="$?"

    local RED='\[\e[0;31m\]'
    local BLUE='\[\e[0;34m\]'
    local PURPLE='\[\e[0;35m\]'
    local WHITE='\[\e[0;37m\]'

    # branch
    local BRANCH=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'`

    # exit status
    local STATUS="$PURPLE"
    [[ "$EXIT_STATUS" == 0 ]] || STATUS="$RED"

    # character
    local CHAR='\$'
    [ "$UID" = 0 ] && CHAR='#'

    PS1="\n${BLUE}\w${WHITE}${BRANCH}\n${STATUS}${CHAR}${WHITE} "
}

export PROMPT_COMMAND=__prompt-command
