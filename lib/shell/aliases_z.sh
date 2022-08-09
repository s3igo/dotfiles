# shell
alias _start='source ~/.config/zsh/.zshrc'

# global
## shell
alias -g _i='install'
alias -g _ls='"$(ls | anyframe-selector-auto)"'
alias -g _ls-a='"$(ls -a | tail -n +3 | anyframe-selector-auto)"'

## docker
alias -g _dp='`docker ps --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | anyframe-selector-auto | cut -d " " -f 1`'
alias -g _dp-a='`docker ps -a --format "table {{.ID}} {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | tail -n +2 | anyframe-selector-auto | cut -d " " -f 1`'

# mac
if [ "$(uname)" = 'Darwin' ]; then
    alias _app='open -a "$(ls /Applications | sed "s/\.app$//" | anyframe-selector-auto)"'
    alias -g _select='| anyframe-selector-auto | anyframe-action-execute'
    alias -g _pick='| anyframe-selector-auto | pbcopy'
fi
