{
  lib,
  runCommand,
  makeBinaryWrapper,

  helix,
  formats,

  nixd,
  nil,
  taplo,
  typos-lsp,
  vtsls,

  settings ? {
    editor.rulers = [
      80
      100
      120
    ];
  },
  languages ? {
    language-server = {
      vtsls = {
        command = lib.getExe vtsls;
        args = [ "--stdio" ];
      };
    };
    language = [
      {
        name = "typescript";
        language-servers = [ "vtsls" ];
      }
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
