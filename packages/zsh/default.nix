{pkgs}:
pkgs.buildEnv {
  name = "zsh";
  paths = [
    (
      pkgs.stdenv.mkDerivation
      {
        name = "zsh-config";
        src = ./starship;
        zshrc = pkgs.writeText "zshrc" ''
          ${import ./shell {inherit pkgs;} }
          ${import ./starship {inherit pkgs;} }
        '';
        installPhase = ''
          mkdir -p $out/{config,starship}
          # ZDOTDIR=$out/config
          cp $zshrc $out/config/.zshrc
          # STARSHIP_CONFIG=$out/starship/config.toml
          cp $src/config.toml $out/starship/
        '';
      }
    )
    pkgs.zsh
    pkgs.eza
    pkgs.git
  ];
}
