# homebrew
[[ "$(uname)" == 'Darwin' ]] \
    && [[ "$(uname -m)" == 'arm64' ]] \
    && eval "$(/opt/homebrew/bin/brew shellenv)"

type sheldon > /dev/null 2>&1 && eval "$(sheldon source)"
