_: {
  imports = [ ./vim ];
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [
      "daipeihust/tap"
      # "homebrew/cask-fonts"
      "homebrew/services"
      "macos-fuse-t/homebrew-cask"
    ];
    brews = [
      "daipeihust/tap/im-select"
      "typst"
    ];
    casks = [
      "1password"
      "anytype"
      "arc"
      "cursor"
      "discord"
      "firefox"
      # "font-ipaexfont"
      # "font-noto-sans-cjk-jp"
      # "font-zen-kaku-gothic-new"
      "google-chrome"
      "google-japanese-ime"
      "macos-fuse-t/homebrew-cask/fuse-t"
      "mullvadvpn"
      "orbstack"
      "raycast"
      "slack"
      "visual-studio-code"
      "vivaldi"
      "zed"
      "zoom"
      {
        name = "chromium";
        args = {
          no_quarantine = true;
        };
      }
      {
        name = "librewolf";
        args = {
          no_quarantine = true;
        };
      }
    ];
  };
}
