{pkgs, ...}: {
  imports = [
    ./git.nix
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
