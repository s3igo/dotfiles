{
  lib,
  stdenv,
  skk-dict,
  yaskkserv2,
  version ? "generated",
  dictionary-filename ? "dictionary.yaskkserv2",
  jisyo-list ? [ "SKK-JISYO.L" ],
}:

# TODO: change to nix-darwin's rev
stdenv.mkDerivation rec {
  pname = "yaskkserv2-dict";
  inherit version;

  src = skk-dict;

  nativeBuildInputs = [ yaskkserv2 ];
  installPhase =
    let
      dictionariesStr = lib.concatStringsSep " " (map (jisyo: "${src}/share/${jisyo}") jisyo-list);
    in
    ''
      runHook preInstall

      mkdir -p $out/share/
      yaskkserv2_make_dictionary --utf8 --dictionary-filename $out/share/${dictionary-filename} -- ${dictionariesStr}

      runHook postInstall
    '';
}
