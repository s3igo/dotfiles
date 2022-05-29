# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Zinit
## theme
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

## autosuggestion
zinit ice wait'!0'
zinit light zsh-users/zsh-autosuggestions

## tab-completion
zinit ice wait'!0'
zinit light zsh-users/zsh-completions

## syntax-highlight
zinit ice wait'!0'
zinit light zdharma-continuum/fast-syntax-highlighting

## open on GitHub
zinit ice wait'!0'
zinit light paulirish/git-open

## auto input closure/quote
zinit ice wait'!0'
zinit light momo-lab/zsh-smartinput

## remove doller from the beginning of line
zinit ice wait'!0'
zinit light zpm-zsh/undollar

## anyframe
zinit ice wait'!0'
zinit light mollifier/anyframe

zle -N anyframe-widget-cdr
zle -N anyframe-widget-execute-history
zle -N anyframe-widget-kill
zle -N anyframe-widget-cd-ghq-repository

bindkey '^R' anyframe-widget-execute-history
bindkey '^G' anyframe-widget-cd-ghq-repository