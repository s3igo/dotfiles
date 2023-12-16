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
  };
}
