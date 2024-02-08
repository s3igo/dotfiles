{ pkgs, direnv, ... }:
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
      package = direnv.packages.${pkgs.system}.default;
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

  xdg.configFile = {
    "act/actrc".text = ''
      -P ubuntu-latest=catthehacker/ubuntu:act-latest
      -P ubuntu-22.04=catthehacker/ubuntu:act-22.04
      -P ubuntu-20.04=catthehacker/ubuntu:act-20.04
      -P ubuntu-18.04=catthehacker/ubuntu:act-18.04
    '';
    nvim.source = ../../config/home/.config/nvim;
  };

  home = {
    file.".ssh/config".text = ''
      Include ~/.orbstack/ssh/config

      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        ForWardAgent yes
    '';
    packages = with pkgs; [
      darwin.trash
      du-dust
      efm-langserver
      emacs-nox
      fd
      ghq
      lazydocker
      mmv-go
      nodejs-slim
      ollama
      rclone
      tree
    ];
  };
}
