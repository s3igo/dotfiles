function timestamp {
    [[ $# == 0 ]] && date '+%Y%m%d%H%M%S' && return 0
    [[ $# > 1 ]] && echo 'error: too many arguments' && return 1

    declare ext="${1#*.}"
    declare now="$(date +%Y%m%d%H%M%S)"
    command mv "$1" "${now}.${ext}"
}

function rosetta {
    [[ $# == 0 ]] && arch -x86_64 zsh && return 0
    arch -x86_64 zsh -c "$*"
}

function hashmv {
    [[ $# == 0 ]] && echo 'error: missing argument' && return 1
    [[ $# > 1 ]] && echo 'error: too many arguments' && return 1

    declare EXT="${1#*.}"
    declare HASH="$(shasum -a 256 "$1" | cut -d ' ' -f 1)"
    declare NAME="${HASH}.${EXT}"

    mv "$1" "$NAME"
    echo "$NAME"
}

function arc {
    open -a 'Arc.app' "$@"
}

