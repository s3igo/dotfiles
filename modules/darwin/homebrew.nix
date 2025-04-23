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
      "arc"
      "bitwarden"
      "deskpad"
      "discord"
      "firefox"
      "ghostty"
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
      "visual-studio-code"
      "whisky"
      "zed"
      "zoom"
      {
        name = "chromium";
        args.no_quarantine = true;
      }
    ];
  };
}
