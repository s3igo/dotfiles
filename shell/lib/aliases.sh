# editor
alias c='code -g'
alias dot='cd ~/.dotfiles && code .'
alias e='emacs'
alias nv='nvim'
alias v='vim'

# homebrew
alias b='brew'

# docker
alias d='docker'

# git
alias g='git'
alias ga='git commit --amend --no-edit'
alias gi="git init && git commit --allow-empty -m 'initial commit'"
alias gp='git push origin main'

# shell
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cp='cp -i'
alias f='find'
alias fn='find . -name'
alias la='ls -a --color=auto'
alias ls='ls --color=auto'
alias mk='mkdir'
alias mv='mv -i'
alias relogin='exec $SHELL -l'
alias to='touch'
alias wh='which'
[ "$SHELL" = '/bin/zsh' ] && alias sz='source ~/.zshrc'
[ "$SHELL" = '/bin/bash' ] && alias sb='source ~/.bashrc'


if [ "$SHELL" = '/bin/zsh' ]; then
	# anyframe
	alias cc='anyframe-widget-cdr && code .'
	alias cd/='ls \
		| anyframe-selector-auto \
		| anyframe-action-execute cd --'
	alias cd.='ls -a \
		| tail -n +3 \
		| anyframe-selector-auto \
		| anyframe-action-execute cd --'
	alias cdr=anyframe-widget-cdr
	alias pk=anyframe-widget-kill

	# global
	## shell
	alias -g i='install'
	alias -g D='`ls | anyframe-selector-auto`'
	alias -g Da='`ls -a \
		| tail -n +3 \
		| anyframe-selector-auto`'

	## docker
	alias -g P='`docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
		| tail -n +2 \
		| anyframe-selector-auto \
		| cut -d " " -f 1`'
	alias -g Pa='`docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
		| tail -n +2 \
		| anyframe-selector-auto \
		| cut -d " " -f 1`'
fi
