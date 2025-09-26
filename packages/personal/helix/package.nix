{
  lib,
  runCommandNoCC,
  makeBinaryWrapper,

  helix,
  formats,

  nixd,
  nil,
  taplo,
  typos-lsp,
  vtsls,

  helixSettings ? {
    editor.rulers = [
      80
      100
      120
    ];
  },
  helixLanguages ? {
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
  helixThemes ?
    let
      mkTransparentTheme = name: {
        inherits = name;
        "ui.background" = "none";
      };
      themes = [
        "jetbrains_dark"
        "catppuccin_mocha"
        "iceberg-dark"
      ];
      transparentThemes = builtins.listToAttrs (
        map (theme: {
          name = "${theme}_transparent";
          value = mkTransparentTheme theme;
        }) themes
      );
    in
    transparentThemes
    // {
      iceberg-custom = transparentThemes.iceberg-dark_transparent // {
        "ui.gutter" = {
          fg = "linenr_fg";
          bg = "none";
        };
        "ui.linenr" = {
          bg = "none";
        };
        "ui.linenr.selected" = {
          fg = "linenr_fg";
          bg = "none";
        };
      };
      catppuccin-custom = transparentThemes.catppuccin_mocha_transparent // {
        "ui.linenr" = "overlay2";
      };
    },
  helixIgnores ? [
    ".direnv/"
    "result"
    "!.helix/"
    "!.github/"
    "!.gitignore"
    "!.gitattributes"
    "!*.local.*"
    "!*.local/"
  ],
}:

let
  tomlFormat = formats.toml { };
in

runCommandNoCC "helix-personal"
  {
    nativeBuildInputs = [ makeBinaryWrapper ];
    meta = helix.meta;
  }
  ''
    mkdir -p $out/share/config/helix
    cp ${tomlFormat.generate "config.toml" helixSettings} $out/share/config/helix/config.toml
    cp ${tomlFormat.generate "languages.toml" helixLanguages} $out/share/config/helix/languages.toml
    echo -n '${lib.concatLines helixIgnores}' > $out/share/config/helix/ignore

    mkdir -p $out/share/config/helix/themes
    ${lib.pipe helixThemes [
      (lib.mapAttrsToList (
        name: value:
        "cp ${tomlFormat.generate "${name}.toml" value} $out/share/config/helix/themes/${name}.toml"
      ))
      (lib.concatLines)
    ]}

    mkdir -p $out/bin
    makeBinaryWrapper ${lib.getExe helix} $out/bin/${helix.meta.mainProgram} \
      --inherit-argv0 \
      --set XDG_CONFIG_HOME "$out/share/config"
  ''
