{ pkgs, ... }:
{
  imports = [
    ./cli
    ./wezterm
  ];

  programs.home-manager.enable = true;

  xdg.enable = true;

  home = {
    language.base = "en_US.UTF-8";
    stateVersion = "23.11";
    packages = with pkgs; [
      monitorcontrol
      udev-gothic-nf
    ];
  };
}
