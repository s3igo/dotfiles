# anyframe
alias cd/='l
	| anyframe-selector-auto \
	| anyframe-action-execute cd --'
alias cd.='ls -a \
	| tail -n +3 \
	| anyframe-selector-auto \
	| anyframe-action-execute cd --'
alias pk=anyframe-widget-kill
