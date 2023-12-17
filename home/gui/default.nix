{ pkgs, ... }: {
  xdg.configFile.wezterm.source = ../../config/home/.config/wezterm;
  programs.wezterm.enable = true;
  home.packages = with pkgs; [
    monitorcontrol
    discord
  ];
}
