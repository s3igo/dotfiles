# auto complete
zinit light marlonrichert/zsh-autocomplete

# theme
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# asdf
zinit ice wait'!0'
zinit light asdf-vm/asdf
declare -x ASDF_DATA_DIR="${HOME}/.local/share/asdf"

# autosuggestion
zinit ice wait'!0'
zinit light zsh-users/zsh-autosuggestions

# tab-completion
zinit ice wait'!0'
zinit light zsh-users/zsh-completions

# syntax-highlight
zinit ice wait'!0'
zinit light zsh-users/zsh-syntax-highlighting
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
zinit light momo-lab/zsh-smartinput

# remove doller from the beginning of line
zinit ice wait'!0'
zinit light zpm-zsh/undollar

# anyframe
zinit ice wait'!0'
zinit light mollifier/anyframe
