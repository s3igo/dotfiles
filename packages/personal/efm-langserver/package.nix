{
  lib,
  runCommand,
  makeBinaryWrapper,

  efm-langserver,
  formats,

  statix,

  # https://docs.helix-editor.com/languages.html?highlight=feature#language-server-configuration
  # Helixの設定ファイル内でconfigをいじった方が良いかも
  settings ? rec {
    version = 2;
    root-markers = [
      ".git/"
      "flake.nix"
    ];
    tools = {
      statix = {
        lint-command = "${lib.getExe statix} check --stdin --format errfmt";
        # https://vimhelp.org/quickfix.txt.html#errorformat
        # https://github.com/oppiliappan/statix/blob/v0.5.8/vim-plugin/ftplugin/nix.vim#L2
        lint-formats = [ "%f>%l:%c:%t:%n:%m" ];
      };
    };
    languages = {
      nix = [ tools.statix ];
    };
  },
}:

let
  yamlFormat = formats.yaml { };
  configFile = yamlFormat.generate "config.yaml" settings;
in

runCommand "efm-langserver-wrapped"
  {
    nativeBuildInputs = [ makeBinaryWrapper ];
    meta.mainProgram = efm-langserver.meta.mainProgram;
  }
  ''
    mkdir -p $out/bin
    makeBinaryWrapper ${lib.getExe efm-langserver} $out/bin/${efm-langserver.meta.mainProgram} \
      --inherit-argv0 \
      --add-flags '-c ${configFile}'
  ''
