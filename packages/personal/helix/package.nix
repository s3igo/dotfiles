{
  lib,
  runCommandNoCC,
  makeBinaryWrapper,
  formats,

  fish,
  helix,

  astro-language-server,
  biome,
  codebook,
  efm-langserver,
  lua-language-server,
  nil,
  nixd,
  nixfmt,
  rust-analyzer,
  statix,
  stylua,
  tailwindcss-language-server,
  taplo,
  typescript-language-server,
  typos-lsp,
  vscode-json-languageserver,
  yaml-language-server,

  helixLanguages ? import ./languages.nix { inherit lib efm-langserver nixfmt; },
  helixSettings ? import ./settings.nix { inherit lib fish; },
  helixThemes ? import ./themes.nix,
  helixIgnores ? import ./ignores.nix,
}:

let
  tomlFormat = formats.toml { };
  configFiles = runCommandNoCC "helix-configs" { } ''
    mkdir -p $out/share
    cp ${tomlFormat.generate "config.toml" helixSettings} $out/share/config.toml
    cp ${tomlFormat.generate "languages.toml" helixLanguages} $out/share/languages.toml
    echo -n '${lib.concatLines helixIgnores}' > $out/share/ignore

    mkdir -p $out/share/themes
    ${lib.pipe helixThemes [
      (lib.mapAttrsToList (
        name: value: "cp ${tomlFormat.generate "${name}.toml" value} $out/share/themes/${name}.toml"
      ))
      lib.concatLines
    ]}
  '';
in

runCommandNoCC "helix-personal"
  {
    nativeBuildInputs = [ makeBinaryWrapper ];
    meta = helix.meta;
    passthru = { inherit configFiles; };
  }
  ''
    mkdir -p $out/share/config/helix
    cp -r ${configFiles}/share/* $out/share/config/helix/

    mkdir -p $out/bin
    makeBinaryWrapper ${lib.getExe helix} $out/bin/${helix.meta.mainProgram} \
      --inherit-argv0 \
      --set XDG_CONFIG_HOME "$out/share/config" \
      --suffix PATH : ${
        lib.makeBinPath [
          astro-language-server
          biome
          codebook
          lua-language-server
          nil
          nixd
          rust-analyzer
          stylua
          tailwindcss-language-server
          taplo
          typescript-language-server
          typos-lsp
          vscode-json-languageserver
          yaml-language-server
        ]
      }
  ''
