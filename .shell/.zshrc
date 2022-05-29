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


SHELL_DIR=~/.dotfiles/.shell/shell

[ -r $SHELL_DIR/config_common.sh ] && source $SHELL_DIR/config_common.sh
[ -r $SHELL_DIR/config_z.sh ] && source $SHELL_DIR/config_z.sh
[ -r $SHELL_DIR/aliases_common.sh ] && source $SHELL_DIR/aliases_common.sh
[ -r $SHELL_DIR/aliases_z.sh ] && source $SHELL_DIR/aliases_z.sh
[ -r $SHELL_DIR/path.sh ] && source $SHELL_DIR/path.sh

[ -r $SHELL_DIR/lang.sh ] && source $SHELL_DIR/lang.sh
[ -r $SHELL_DIR/aliases_plugin.sh ] && source $SHELL_DIR/aliases_plugin.sh
