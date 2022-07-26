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
[ "$SHELL" = '/bin/zsh' ] && alias restart='source ~/.zshrc'
[ "$SHELL" = '/bin/bash' ] && alias restart='source ~/.bashrc'
