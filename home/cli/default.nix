{ ... }: {
  imports = [ ./starship.nix ./zsh ];

  programs = {
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    fzf.enable = true;
  };
}
