{ pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      font-family = "UDEV Gothic NFLG";
      font-size = 16;
      theme = "iceberg-dark";
      minimum-contrast = 1.1;
      cursor-style-blink = false;
      mouse-hide-while-typing = true;
      background-opacity = 0.7;
      command = "${lib.getExe pkgs.fish} --login";
      initial-command = "${lib.getExe pkgs.zellij} --layout welcome";
      link-url = true;
      keybind = [ "global:super+grave_accent=toggle_quick_terminal" ];
      window-padding-x = 5;
      window-padding-balance = true;
      shell-integration-features = "no-cursor";
      # -- macOS only --
      window-title-font-family = "UDEV Gothic NFLG";
      window-colorspace = "display-p3";
      quick-terminal-position = "bottom";
      macos-option-as-alt = true;
    };
  };
}
