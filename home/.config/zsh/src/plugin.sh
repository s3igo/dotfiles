# auto complete
zinit light marlonrichert/zsh-autocomplete

# theme
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# autosuggestion
zinit ice wait'!0'
zinit light zsh-users/zsh-autosuggestions

## keybind
bindkey '^J' menu-select

# tab-completion
zinit ice wait'!0'
zinit light zsh-users/zsh-completions

# syntax-highlight
zinit ice wait'!0'
zinit light zsh-users/zsh-syntax-highlighting

## color
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main line brackets cursor)
declare -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold' # alias
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,bold' # exist path
ZSH_HIGHLIGHT_STYLES[root]='bg=red' # root

# open on GitHub
zinit ice wait'!0'
zinit light paulirish/git-open

# auto input closure/quote
zinit ice wait'!0'
zinit light hlissner/zsh-autopair

# remove doller from the beginning of line
zinit ice wait'!0'
zinit light zpm-zsh/undollar

# anyframe
zinit ice wait'!0'
zinit light mollifier/anyframe

## cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zle -N anyframe-widget-cdr
bindkey '^S' anyframe-widget-cdr

## command history
zle -N anyframe-widget-execute-history
bindkey '^R' anyframe-widget-execute-history

## ghq
function __ghq-fzf {
    anyframe-source-ghq-repository \
        | fzf --preview "command exa --tree --git-ignore -I 'node_modules|.git' {}" \
        | anyframe-action-execute cd --
}
zle -N __ghq-fzf
bindkey '^G' __ghq-fzf
