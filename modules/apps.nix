{ ... }: {
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
      "idleberg/dbxcli"
    ];
    brews = [
      "act"
      "daipeihust/tap/im-select"
      "fnm"
      "gh"
      "helix"
      "idleberg/dbxcli/dbxcli"
      "neovim"
      "ollama"
      "rustup-init"
      "sheldon"
      "typst"
      "zk"
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
      "mochi-diffusion"
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
        args = { no_quarantine = true; };
      }
    ];
    masApps = {
      Things = 904280696;
      LINE = 539883307;
    };
  };
}
