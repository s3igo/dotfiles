# shell
alias restart='source ~/.zshrc'

# anyframe
alias cc='anyframe-widget-cdr && code .'
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
