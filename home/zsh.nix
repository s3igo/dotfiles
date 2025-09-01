{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    history = {
      ignoreAllDups = true;
      path = "${config.xdg.stateHome}/zsh/history";
    };
  };
}
