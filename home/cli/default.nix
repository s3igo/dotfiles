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

  home.packages = with pkgs; [
    darwin.trash
    efm-langserver
    fd
    ghq
    lazydocker
    mmv-go
  ];
}
