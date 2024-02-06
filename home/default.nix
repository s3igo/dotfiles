{ pkgs, ... }:
{
  imports = [
    ./cli
    ./wezterm
  ];
  home = {
    language.base = "en_US.UTF-8";
    stateVersion = "23.11";
    packages = with pkgs; [
      monitorcontrol
      udev-gothic-nf
    ];
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
}
