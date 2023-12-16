declare -x ZDOTDIR="${HOME}/.config/zsh"

declare -x XDG_CONFIG_HOME="${HOME}/.config"
declare -x XDG_CACHE_HOME="${HOME}/.cache"
declare -x XDG_DATA_HOME="${HOME}/.local/share"
declare -x XDG_STATE_HOME="${HOME}/.local/state"

# if [[ "$(uname)" == 'Darwin' ]]; then
#     # ignore `/etc/zprofile` to avoid overwriting the PATH via /usr/libexec/path_helper
#     unsetopt GLOBAL_RCS
# fi
