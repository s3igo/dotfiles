_: {
  imports = [
    ./vim.nix
  ];
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [
      "daipeihust/tap"
      "homebrew/cask-fonts"
      "homebrew/services"
    ];
    brews = [
      "daipeihust/tap/im-select"
      "fnm"
      "rustup-init"
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
      "firefox"
      "font-ipaexfont"
      "font-noto-sans-cjk-jp"
      "font-udev-gothic-nf"
      "font-zen-kaku-gothic-new"
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
      "zed"
      "zoom"
      {
        name = "chromium";
        args = {no_quarantine = true;};
      }
    ];
    masApps = {
      Things = 904280696;
      LINE = 539883307;
    };
  };
}
