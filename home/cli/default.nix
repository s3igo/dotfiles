{ ... }: {
  imports = [ ./starship.nix ];

  programs = {
    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };
  };
}
