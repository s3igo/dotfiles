{ pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      font-family = "UDEV Gothic NF";
      font-size = 16;
      theme = "Iceberg Dark";
      minimum-contrast = 1.1;
      cursor-style-blink = false;
      mouse-hide-while-typing = true;
      background-opacity = 0.7;
      command = "${lib.getExe pkgs.fish} --login";
      link-url = true;
      working-directory = "home";
      keybind = [
        "global:super+grave_accent=toggle_quick_terminal"
        "super+s=new_split:left"
        "super+shift+s=new_split:up"
        "shift+space=ignore" # Avoid conflict with IME keybindings
        # 現状Helixのコンポジターコンポーネント（ピッカーやプロンプト）はキーリマップ非対応なので、
        # そこで`<C-[>`を機能させるため
        # https://github.com/helix-editor/helix/issues/5505
        # https://github.com/helix-editor/helix/issues/6551#issuecomment-1929283622
        "ctrl+[=text:\\x1b"
      ];
      window-padding-x = 5;
      window-padding-balance = true;
      window-inherit-working-directory = false;
      shell-integration-features = "no-cursor";
      # -- macOS only --
      window-title-font-family = "UDEV Gothic NF";
      window-colorspace = "display-p3";
      quick-terminal-position = "bottom";
      macos-option-as-alt = true;
    };
  };
}
