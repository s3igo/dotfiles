{pkgs}: let
  repo = "chissoku";
  rev = "2.1.1";
  hash = "sha256-1K9LTnOl2NFJJdYIhzEPiSD5HCQr5YWjnNr5S2VNuLI=";
  system = "darwin-arm64";
in
  pkgs.stdenv.mkDerivation {
    pname = repo;
    version = "v${rev}";

    src = pkgs.fetchurl {
      url = "https://github.com/northeye/chissoku/releases/download/v${rev}/chissoku-v${rev}-${system}.tar.gz";
      sha256 = hash;
    };

    sourceRoot = ".";

    installPhase = "install -m 755 -D chissoku $out/bin/chissoku";
  }
