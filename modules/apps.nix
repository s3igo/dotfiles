{ config, ... }:

{
  imports = [ ./vim ];
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    taps = builtins.attrNames config.nix-homebrew.taps;
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
      "zen-browser"
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
