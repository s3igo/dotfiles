{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history = {
      ignoreAllDups = true;
      path = "${config.xdg.stateHome}/zsh/history";
    };
  };
}
