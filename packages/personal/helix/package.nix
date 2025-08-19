{
  lib,
  formats,
  helix,
  runCommand,
  makeBinaryWrapper,
}:

let
  settings = {
    editor.rulers = [
      80
      100
      120
    ];
  };

  tomlFormat = formats.toml { };
  configFile = tomlFormat.generate "config.toml" settings;
in

runCommand "helix-wrapped" { nativeBuildInputs = [ makeBinaryWrapper ]; } ''
  mkdir -p $out/bin
  makeBinaryWrapper ${lib.getExe helix} $out/bin/${helix.meta.mainProgram} \
    --inherit-argv0 \
    --add-flags '--config ${configFile}'
''
