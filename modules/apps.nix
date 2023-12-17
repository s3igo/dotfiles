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
      "yqrashawn/goku"
    ];
    brews = [
      "act"
      "daipeihust/tap/im-select"
      "fnm"
      "gh"
      "grex"
      "helix"
      "hexyl"
      "idleberg/dbxcli/dbxcli"
      "just"
      "lf"
      "mas"
      "neovim"
      "ollama"
      "pastel"
      "procs"
      "rustup-init"
      "sheldon"
      "shellharden"
      "silicon"
      "tokei"
      "tree"
      "typst"
      "yqrashawn/goku/goku"
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
      "discord"
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
      "monitorcontrol"
      "morgen"
      "orbstack"
      "orion"
      "raycast"
      "routine"
      "slack"
      "visual-studio-code"
      "wezterm"
      "zed"
      "zoom"
    ];
  };
}
