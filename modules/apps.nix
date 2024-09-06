{
  imports = [ ./vim ];
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    taps = [
      # "homebrew/cask-fonts"
      "homebrew/services"
      "macos-fuse-t/homebrew-cask"
      {
        name = "zen-browser/browser";
        clone_target = "https://github.com/zen-browser/desktop.git";
      }
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
      "monitorcontrol"
      "mullvadvpn"
      "ollama"
      "orbstack"
      "raycast"
      "slack"
      "steam"
      # "thorium"
      "visual-studio-code"
      "vivaldi"
      "whisky"
      "zed"
      "zen-browser/browser/zen-browser"
      "zoom"
      {
        name = "chromium";
        args.no_quarantine = true;
      }
    ];
    # Install manually due to the error of `darwin-rebuild`
    # masApps.Bitwarden = 1352778147;
  };
}
