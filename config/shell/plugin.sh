# theme
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# autosuggestion
zinit ice wait'!0'
zinit light zsh-users/zsh-autosuggestions

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

# auto input closure/quote
zinit ice wait'!0'
zinit light hlissner/zsh-autopair

# remove doller from the beginning of line
zinit ice wait'!0'
zinit light zpm-zsh/undollar

# anyframe
zinit ice wait'!0'
zinit light mollifier/anyframe
