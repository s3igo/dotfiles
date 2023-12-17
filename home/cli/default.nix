{ pkgs, ... }: {
  imports = [
    ./git.nix
    ./starship.nix
    ./zsh
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    fzf.enable = true;
    jq.enable = true;
    lazygit.enable = true;
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
      arguments = [ "--smart-case" ];
    };
  };

  home.packages = with pkgs; [
    efm-langserver
    fd
    ghq
    lazydocker
    darwin.trash
    mmv-go
  ];
}
