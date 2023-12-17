{ ... }: {
  imports = [ ./starship.nix ./zsh ];

  programs = {
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    fzf.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza ={
      enable = true;
      enableAliases = true;
      git = true;
      icons = true;
    };
    bat.enable = true;
    bottom.enable = true;
    jq.enable = true;
    lazygit.enable = true;
  };
}
