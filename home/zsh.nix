{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history = {
      ignoreAllDups = true;
      ignorePatterns = [ "cd *" ];
      path = "${config.xdg.stateHome}/zsh/history";
    };
    initExtraFirst = ''
      if [[ "$(uname)" == 'Darwin' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      export LANG="en_US.UTF-8"

      unsetopt beep
      setopt correct

      # avoid overwriting existing files
      set -o noclobber

      # avoid exiting with Ctrl-D
      set -o ignoreeof

      # avoid duplicate paths
      typeset -U path cdpath fpath manpath

      # completion
      autoload -U compinit && compinit
      zstyle ':completion:*' menu select interactive
      setopt menu_complete
      zmodload -i zsh/complist
      bindkey -M menuselect '^N' down-line-or-history
      bindkey -M menuselect '^P' up-line-or-history

      # use emacs keymap as the default
      bindkey -e

      # bindkey
      bindkey '^U' backward-kill-line
    '';
  };
}
