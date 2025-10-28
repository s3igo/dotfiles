{ pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = builtins.foldl' lib.recursiveUpdate { } [
      {
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
          # 現状Helixのコンポジターコンポーネント（ピッカーやプロンプト）はキーリマップ非対応なので、
          # そこで`<C-[>`を機能させるため、ターミナルで<C-[>を<Esc>に割り当てちゃうことにする
          # https://github.com/helix-editor/helix/issues/5505
          # https://github.com/helix-editor/helix/issues/6551#issuecomment-1929283622
          "ctrl+[=text:\\x1b"
        ];
        window-padding-x = 5;
        window-padding-balance = true;
        window-inherit-working-directory = false;
        # https://github.com/ghostty-org/ghostty/issues/8681
        shell-integration-features = "no-cursor";
      }
      (lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
        window-title-font-family = "UDEV Gothic NF";
        window-colorspace = "display-p3";
        quick-terminal-position = "bottom";
        macos-option-as-alt = true;
      })
    ];
  };
}
