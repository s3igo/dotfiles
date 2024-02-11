{ pkgs, ... }:
{
  imports = [ ./coding.nix ];

  extraPackages = with pkgs; [
    fd
    ripgrep
  ];
}
