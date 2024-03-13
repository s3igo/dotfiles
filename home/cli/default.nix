{ pkgs, config, ... }:

{
  imports = [
    ./git.nix
    ./helix.nix
    ./lazygit.nix
    ./fish.nix
    ./lf.nix
    ./starship.nix
    ./zsh
  ];

  programs = {
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
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
  };

  xdg.configFile.nvim.source = ../../config/home/.config/nvim;

  home = {
    sessionVariables = {
      SSH_AUTH_SOCK = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      DOCKER_CONFIG = "${config.xdg.configHome}/docker";
      _ZO_DATA_DIR = "${config.xdg.dataHome}/zoxide";
      LESSHISTFILE = "-"; # avoid creating `.lesshst`
      NODE_REPL_HISTORY = "";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      FLY_CONFIG_DIR = "${config.xdg.stateHome}/fly";
    };
    packages = with pkgs; [
      darwin.trash
      # du-dust
      # efm-langserver
      # emacs-nox
      fd
      ghq
      # lazydocker
      mmv-go
      # nodejs-slim
      ollama
      rclone
      tree
      _1password
    ];
  };
}
