_: {
  imports = [
    ./cli
    ./gui
  ];
  home = {
    language.base = "en_US.UTF-8";
    stateVersion = "23.11";
  };
  xdg.enable = true;
  programs.home-manager.enable = true;
}
