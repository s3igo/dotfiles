{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation rec {
  pname = "skk-dict";
  version = "2024-08-29";

  src = fetchFromGitHub {
    owner = "skk-dev";
    repo = "dict";
    rev = "4eb91a3bbfef70bde940668ec60f3beae291e971";
    hash = "sha256-sWz85Q6Bu2WoKsckSp5SlcuPUQN2mcq+BHMqNXQ/aho=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share
    cp SKK-JISYO.* $out/share/
    cp zipcode/SKK-JISYO.* $out/share/

    runHook postInstall
  '';

  passthru.list =
    let
      sources = [
        src
        (src + "/zipcode")
      ];
      paths = with builtins; concatMap (path: attrNames (readDir path)) sources;
    in
    builtins.filter (lib.hasPrefix "SKK-JISYO.") paths;
}
