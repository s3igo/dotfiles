{
  stdenv,
  skk-dict,
  yaskkserv2,
  version ? "nightly",
}:

# TODO: change to nix-darwin's rev
stdenv.mkDerivation {
  pname = "yaskkserv2-dict";
  inherit version;

  src = skk-dict;

  nativeBuildInputs = [ yaskkserv2 ];
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/
    yaskkserv2_make_dictionary --utf8 --dictionary-filename $out/share/dictionary.yaskkserv2 -- $src/share/SKK-JISYO.L

    runHook postInstall
  '';
}
