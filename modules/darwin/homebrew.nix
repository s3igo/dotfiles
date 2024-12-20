{
  config,
  user,
  inputs,
  ...
}:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    enable = true;
    inherit user;
    taps = with inputs; {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "macos-fuse-t/homebrew-cask" = macos-fuse-t-cask;
    };
    mutableTaps = false;
  };

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
      "bitwarden"
      "cursor"
      "deskpad"
      "discord"
      "firefox"
      # "font-ipaexfont"
      # "font-noto-sans-cjk-jp"
      # "font-zen-kaku-gothic-new"
      "google-chrome"
      "inkscape"
      "keycastr"
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
  };
}
