{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./git.nix
    ./helix.nix
    ./lazygit.nix
    ./lf
    ./zsh
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    fzf.enable = true;
    jq.enable = true;
    starship.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      config.global.warn_timeout = 0;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
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
      arguments = ["--smart-case"];
    };
  };

  home = {
    activation.installGhCompletion = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p ${config.xdg.dataHome}/zsh/site-functions
      ${pkgs.gh}/bin/gh completion -s zsh > ${config.xdg.dataHome}/zsh/site-functions/_gh
    '';

    file.".ssh/config".text = ''
      Include ~/.orbstack/ssh/config

      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        ForWardAgent yes
    '';
  };

  xdg.configFile = {
    "act/actrc".text = ''
      -P ubuntu-latest=catthehacker/ubuntu:act-latest
      -P ubuntu-22.04=catthehacker/ubuntu:act-22.04
      -P ubuntu-20.04=catthehacker/ubuntu:act-20.04
      -P ubuntu-18.04=catthehacker/ubuntu:act-18.04
    '';
    nvim.source = ../../config/home/.config/nvim;
    "starship.toml".source = ../../packages/zsh/starship/config.toml;
  };

  home.packages = with pkgs; [
    darwin.trash
    efm-langserver
    fd
    ghq
    lazydocker
    mmv-go
    ollama
    rclone
    (import ./chissoku.nix {inherit pkgs;})
  ];
}
