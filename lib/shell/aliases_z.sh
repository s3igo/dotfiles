# shell
alias _start='source ~/.config/zsh/.zshrc'

# global
## shell
alias -g _head='cut -d " " -f 1'
alias -g _i='install'
alias -g _opt=anyframe-selector-auto

## docker
alias -g _dp='`docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | anyframe-selector-auto | cut -d " " -f 1`'
alias -g _dp-a='`docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | anyframe-selector-auto | cut -d " " -f 1`'

# mac
if [ "$(uname)" = 'Darwin' ]; then
    alias -g _pick='| anyframe-selector-auto | pbcopy'
fi
