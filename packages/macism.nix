{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation rec {
  pname = "macism";
  version = "2.0.0";

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  src = passthru.sources.${stdenvNoCC.hostPlatform.system};

  installPhase = ''
    runHook preInstall

    install -Dm755 $src $out/bin/macism

    runHook postInstall
  '';

  passthru = {
    sources = {
      aarch64-darwin = fetchurl {
        url = "https://github.com/laishulu/macism/releases/download/v${version}/macism-arm64";
        hash = "sha256-wp67/zR1Dc0n+i1G1vX0e7Gx6E/7PszWVI6bQDI3JF8=";
      };
      x86_64-darwin = fetchurl {
        url = "https://github.com/laishulu/macism/releases/download/v${version}/macism-x86_64";
        hash = "sha256-Tsg2WuXMivgp8452cJPI2S9+6sADTYTn4Ncw3wf6QrE=";
      };
    };
  };

  meta = {
    description = "Command line MacOS Input Source Manager";
    homepage = "https://github.com/laishulu/macism";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "macism";
    platforms = lib.platforms.darwin;
  };
}
