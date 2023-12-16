{ lib, ... }:
let
  user = "s3igo";
in
{
  imports = [
    ./cli
  ];
  home = {
    username = user;
    homeDirectory = lib.mkForce "/Users/${user}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
