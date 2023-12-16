{ ... }: {
  imports = [ ./starship.nix ];

  programs = {
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
    fzf.enable = true;
    # zsh.enable = true;
  };
}
