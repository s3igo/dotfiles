{pkgs}: ''
  source ${./config.zsh}

  source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh

  source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_HIGHLIGHTERS+=('main' 'line' 'brackets' 'cursor')
  ZSH_HIGHLIGHT_STYLES+=('alias' 'fg=cyan,bold')
  ZSH_HIGHLIGHT_STYLES+=('path' 'fg=yellow,bold')
  ZSH_HIGHLIGHT_STYLES+=('root' 'bg=red')

  source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey "^P" history-substring-search-up
  bindkey "^N" history-substring-search-down
''
