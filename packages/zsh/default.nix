{pkgs}:
pkgs.buildEnv {
  name = "zsh";
  paths = [
    (
      pkgs.stdenv.mkDerivation
      {
        name = "zsh-config";
        src = ./.;
        zshrc = pkgs.writeText "zshrc" import ./config.nix {inherit pkgs;};
        installPhase = ''
          mkdir -p $out/config
          cp $zshrc $out/config/.zshrc
        '';
      }
    )
    pkgs.zsh
    pkgs.eza
    pkgs.git
  ];
}
