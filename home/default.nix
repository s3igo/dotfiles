{ lib, ... }:
let
  user = "s3igo";
in
{
  imports = [
    ./starship.nix
  ];
  home = {
    username = user;
    homeDirectory = lib.mkForce "/Users/${user}";
    stateVersion = "23.11";
  };
  programs.home-manager.enable = true;
}
