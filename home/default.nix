{
  self,
  pkgs,
  config,
  osConfig,
  ...
}:

let
  inherit (config.xdg) configHome dataHome stateHome;
  inherit (config.home) homeDirectory;
in

{
  imports = [
    ./fzf
    ./wezterm
    ./aider.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./joshuto.nix
    ./pager.nix
    ./rio.nix
    ./fish.nix
    ./starship.nix
    ./zellij.nix
    ./zsh.nix
  ];

  programs = {
    home-manager.enable = true;
    ssh = {
      enable = true;
      includes = [ "~/.orbstack/ssh/config" ];
      forwardAgent = true;
      extraConfig = ''
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      '';
    };
    bat.enable = true;
    bottom.enable = true;
    jq.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      config.global = {
        warn_timeout = 0;
        hide_env_diff = true;
      };
      nix-direnv.enable = true;
      stdlib = ''
        if [ -f shell.local.nix ]; then
          use_nix shell.local.nix
          watch_file shell.local.nix
          watch_dir npins.local
        fi
      '';
    };
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
  };

  xdg = {
    enable = true;
    configFile."npm/npmrc".text = ''
      prefix=''${XDG_DATA_HOME}/npm
      logs-dir=''${XDG_DATA_HOME}/npm/log
      cache=''${XDG_CACHE_HOME}/npm
      update-notifier=false
    '';
  };

  home = {
    language.base = "en_US.UTF-8";
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11";
    sessionVariables = {
      RCLONE_CONFIG = osConfig.age.secrets.rclone-config.path;
      SSH_AUTH_SOCK = "${homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      DOCKER_CONFIG = "${configHome}/docker";
      _ZO_DATA_DIR = "${dataHome}/zoxide";
      LESSHISTFILE = "-"; # avoid creating `.lesshst`
      NODE_REPL_HISTORY = "";
      CARGO_HOME = "${dataHome}/cargo";
      FLY_CONFIG_DIR = "${stateHome}/fly";
      NPM_CONFIG_USERCONFIG = "${configHome}/npm/npmrc";
      EDITOR = "nvim";
    };
    packages =
      with pkgs;
      [
        # efm-langserver
        # emacs-nox
        _1password-cli
        aichat
        attic-client
        # bitwarden-cli # Fails to build https://github.com/NixOS/nixpkgs/pull/350601 https://github.com/NixOS/nixpkgs/issues/339576
        darwin.trash
        fd
        ghq
        rclone
        tdf
        tree
      ]
      ++ [ self.packages.${pkgs.stdenv.hostPlatform.system}.neovim-extra ];
  };
}
