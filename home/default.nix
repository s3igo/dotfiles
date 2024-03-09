{ pkgs, ... }:
{
  imports = [
    ./cli
    ./wezterm
  ];

  programs.home-manager.enable = true;
  programs = {
    rio.enable = true;
  };

  xdg = {
    enable = true;
    configFile."npm/npmrc".text = ''
      prefix=''${XDG_DATA_HOME}/npm
      logs-dir=''${XDG_DATA_HOME}/npm/log
      cache=''${XDG_CACHE_HOME}/npm
      update-notifier=false
    '';
  };

  home = {
    language.base = "en_US.UTF-8";
    stateVersion = "23.11";
    packages = with pkgs; [
      monitorcontrol
      udev-gothic-nf
    ];
  };
}
