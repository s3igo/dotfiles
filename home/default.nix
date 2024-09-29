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
    ./git.nix
    ./helix.nix
    ./joshuto.nix
    ./fish.nix
    ./starship.nix
    ./zsh.nix
    ./wezterm
  ];

  programs = {
    home-manager.enable = true;
    # rio.enable = true;
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
    fzf = {
      enable = true;
      changeDirWidgetCommand = "fd --type directory --hidden --follow --exclude .git";
      changeDirWidgetOptions = [ "--preview 'ls -la {}'" ];
      defaultCommand = "fd --type file --hidden --follow --exclude .git";
    };
    jq.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      config.global = {
        warn_timeout = 0;
        hide_env_diff = true;
      };
      nix-direnv.enable = true;
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
      AICHAT_CONFIG_DIR = "${configHome}/aichat";
      EDITOR = "nvim";
    };
    packages =
      with pkgs;
      [
        # efm-langserver
        # emacs-nox
        _1password
        aichat
        aider-chat
        attic-client
        darwin.trash
        dust
        fd
        ghq
        moar
        rclone
        tree
      ]
      ++ [ self.packages.${pkgs.system}.default ];
  };
}
