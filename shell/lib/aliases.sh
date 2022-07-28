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
## to avoid making mistakes
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
## cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
## ls
alias la='ls -hla --color=auto'
alias ll='ls -hl --color=auto'
alias ls='ls --color=auto'
## find
alias f='find'
alias fn='find . -name'
## others
alias mk='mkdir'
alias to='touch'
alias wh='which'
alias relogin='exec $SHELL -l'
