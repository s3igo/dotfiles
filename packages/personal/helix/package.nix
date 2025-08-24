{
  lib,
  formats,
  runCommand,
  makeBinaryWrapper,
  helix,

  nixd,
  nil,
  taplo,
  typos-lsp,

  settings ? {
    editor.rulers = [
      80
      100
      120
    ];
  },
}:

let
  tomlFormat = formats.toml { };
  configFile = tomlFormat.generate "config.toml" settings;
in

runCommand "helix-wrapped"
  {
    nativeBuildInputs = [ makeBinaryWrapper ];
    meta.mainProgram = helix.meta.mainProgram;
  }
  ''
    mkdir -p $out/bin
    makeBinaryWrapper ${lib.getExe helix} $out/bin/${helix.meta.mainProgram} \
      --inherit-argv0 \
      --add-flags '--config ${configFile}'
  ''
