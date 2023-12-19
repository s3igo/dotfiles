_: {
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    taps = [
      "candid82/brew"
      "daipeihust/tap"
      "homebrew/cask-fonts"
      "homebrew/services"
    ];
    brews = [
      "daipeihust/tap/im-select"
      "fnm"
      "gh"
      "helix"
      "neovim"
      "ollama"
      "rustup-init"
      "typst"
    ];
    casks = [
      "1password"
      "1password-cli"
      "adobe-acrobat-pro"
      "anytype"
      "arc"
      "brave-browser"
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
