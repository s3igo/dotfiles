# editor
alias c='code'
alias dot='cd ~/.dotfiles && code .'
alias e='emacs'
alias nv='nvim'
alias v='vim'

# homebrew
alias b='brew'

# docker
alias d='docker'
alias dc='docker-compose'
alias dp='docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'

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
alias sl='ls --color=auto' # in case of typo
alias to='touch'
alias w='which'