{ lib, ... }:
let
  user = "s3igo";
in
{
  imports = [
    ./cli
    ./gui
  ];
  home = {
    username = user;
    homeDirectory = lib.mkForce "/Users/${user}";
    language.base = "en_US.UTF-8";
    stateVersion = "23.11";
  };
  xdg.enable = true;
  programs.home-manager.enable = true;
}
