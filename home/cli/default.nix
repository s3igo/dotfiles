{pkgs, ...}: {
  imports = [
    ./git.nix
    ./helix.nix
    ./lazygit.nix
    ./lf
    ./starship.nix
    ./zsh
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    fzf.enable = true;
    jq.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
    ripgrep = {
      enable = true;
      arguments = ["--smart-case"];
    };
  };

  home.file.".ssh/config".text = ''
    Include ~/.orbstack/ssh/config

    Host *
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      ForWardAgent yes
  '';

  xdg.configFile."act/actrc".text = ''
    -P ubuntu-latest=catthehacker/ubuntu:act-latest
    -P ubuntu-22.04=catthehacker/ubuntu:act-22.04
    -P ubuntu-20.04=catthehacker/ubuntu:act-20.04
    -P ubuntu-18.04=catthehacker/ubuntu:act-18.04
  '';

  home.packages = with pkgs; [
    darwin.trash
    efm-langserver
    fd
    ghq
    lazydocker
    mmv-go
  ];
}
