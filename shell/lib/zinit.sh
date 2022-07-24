### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
	print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
	command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
	command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
		print -P "%F{33} %F{34}Installation successful.%f%b" || \
		print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
zdharma-continuum/zinit-annex-as-monitor \
zdharma-continuum/zinit-annex-bin-gem-node \
zdharma-continuum/zinit-annex-patch-dl \
zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk


# plugin
# auto complete
zinit light marlonrichert/zsh-autocomplete

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

### cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zle -N anyframe-widget-cdr

### command history
zle -N anyframe-widget-execute-history
bindkey '^R' anyframe-widget-execute-history

### process kill
zle -N anyframe-widget-kill

### ghq
zle -N anyframe-widget-cd-ghq-repository
bindkey '^G' anyframe-widget-cd-ghq-repository
