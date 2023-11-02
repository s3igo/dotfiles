type sheldon > /dev/null 2>&1 && eval "$(sheldon source)"
zle -N _atuin_search
bindkey '^R' _atuin_search
function __atuin-dir-search {
    _atuin_search --filter-mode directory
}
zle -N __atuin-dir-search
bindkey '^X^R' __atuin-dir-search

