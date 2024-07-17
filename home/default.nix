{
  pkgs,
  config,
  neovim,
  user,
  ...
}:

{
  imports = [
    ./git.nix
    ./helix.nix
    ./lazygit.nix
    ./fish.nix
    ./starship.nix
    ./yazi.nix
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
    gh = {
      enable = true;
      settings = {
        # workaround for https://github.com/nix-community/home-manager/issues/4744
        # see: https://github.com/cli/cli/issues/8462
        version = 1;
        git_protocol = "ssh";
      };
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
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      _ZO_DATA_DIR = "${config.xdg.dataHome}/zoxide";
      # LESSHISTFILE = "-"; # avoid creating `.lesshst`
      PAGER = "/etc/profiles/per-user/${user}/bin/moar";
      NODE_REPL_HISTORY = "";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      FLY_CONFIG_DIR = "${config.xdg.stateHome}/fly";
      NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
      EDITOR = "nvim";
    };
    packages =
      with pkgs;
      [
        darwin.trash
        monitorcontrol
        udev-gothic-nf
        attic-client
        # du-dust
        # efm-langserver
        # emacs-nox
        fd
        ghq
        # lazydocker
        # mmv-go
        moar
        # nodejs-slim
        ollama
        rclone
        tree
        _1password
      ]
      ++ [ neovim ];
  };
}
