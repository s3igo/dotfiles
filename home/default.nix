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
    ./aider.nix
    ./fish.nix
    ./fzf.nix
    ./ghostty.nix
    ./git.nix
    ./helix.nix
    ./joshuto.nix
    ./pager.nix
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
    fd.enable = true;
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
    pet = {
      enable = true;
      settings = {
        General = {
          Color = true;
          Editor = "nvim";
          SelectCmd = "fzf --ansi --reverse";
        };
      };
    };
  };

  xdg = {
    enable = true;
    configFile."npm/npmrc".text = ''
      prefix=''${XDG_DATA_HOME}/npm
      cache=''${XDG_CACHE_HOME}/npm
      tmp=''${TMPDIR}npm
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
      # https://github.com/ajeetdsouza/zoxide?tab=readme-ov-file#environment-variables
      _ZO_DATA_DIR = if pkgs.stdenv.isDarwin then "${dataHome}/zoxide" else null;
      LESSHISTFILE = "-"; # To prevent creation of the `.lesshst` file
      NODE_REPL_HISTORY = "";
      CARGO_HOME = "${dataHome}/cargo";
      FLY_CONFIG_DIR = "${stateHome}/fly";
      NPM_CONFIG_USERCONFIG = "${configHome}/npm/npmrc";
      EDITOR = "nvim";
    };
    packages =
      with pkgs;
      [
        _1password-cli
        aichat
        attic-client
        bitwarden-cli
        darwin.trash
        dust
        ghq
        rclone
        smartcat
        tree
      ]
      ++ [ self.packages.${pkgs.stdenv.hostPlatform.system}.neovim-extra ];
  };
}
