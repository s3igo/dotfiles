_: {
  imports = [
    ./vim
  ];
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
    ];
    brews = [
      "daipeihust/tap/im-select"
      "fnm"
      # "rustup-init"
      "typst"
    ];
    casks = [
      "1password"
      "1password-cli"
      "anytype"
      "arc"
      "cloudflare-warp"
      "cron"
      "cursor"
      "dropbox"
      "discord"
      "firefox"
      # "font-ipaexfont"
      # "font-noto-sans-cjk-jp"
      # "font-zen-kaku-gothic-new"
      "floorp"
      "google-chrome"
      "google-japanese-ime"
      "karabiner-elements"
      "keyboardcleantool"
      "morgen"
      "orbstack"
      "orion"
      "raycast"
      "routine"
      "slack"
      "visual-studio-code"
      "vivaldi"
      "zed"
      "zoom"
      {
        name = "chromium";
        args = {no_quarantine = true;};
      }
      {
        name = "librewolf";
        args = {no_quarantine = true;};
      }
    ];
    masApps = {
      Things = 904280696;
      LINE = 539883307;
    };
  };
}
