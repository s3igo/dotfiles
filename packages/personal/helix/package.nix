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
  nil,
  nixd,
  nixfmt,
  statix,
  tailwindcss-language-server,
  taplo,
  typescript-language-server,
  typos-lsp,
  vscode-json-languageserver,

  helixLanguages ? {
    language-server = {
      astro-ls.command = lib.getExe astro-language-server;
      # https://biomejs.dev/guides/editors/third-party-extensions/#helix
      biome = {
        command = lib.getExe biome;
        args = [ "lsp-proxy" ];
      };
      codebook = {
        command = lib.getExe codebook;
        args = [ "serve" ];
      };
      # WIP: なんか動かない
      efm-nix = {
        command = lib.getExe efm-langserver;
        # args = [
        #   "-logfile"
        #   "/Users/s3igo/.dotfiles/efm.local.log"
        # ];
        config = {
          languages.nix = [
            {
              lintCommand = "${lib.getExe statix} check --format errfmt \${INPUT}";
              # lintCommand = "${lib.getExe statix} check --format errfmt";
              # lintWorkspace = true;
              lintIgnoreExitCode = true;
              lintStdin = false;
              rootMarkers = [ "flake.nix" ];
              # https://vimhelp.org/quickfix.txt.html#errorformat
              # https://github.com/oppiliappan/statix/blob/v0.5.8/vim-plugin/ftplugin/nix.vim#L2
              lintFormats = [ "%f>%l:%c:%t:%n:%m" ];
            }
          ];
        };
      };
      nil.command = lib.getExe nil;
      nixd.command = lib.getExe nixd;
      tailwindcss-ls = {
        command = lib.getExe tailwindcss-language-server;
        config.tailwindCSS.classAttributes =
          let
            default = [
              "class"
              "className"
              "ngClass"
              "class:list"
            ];
          in
          default ++ [ ".*Classes" ];
      };
      taplo.command = lib.getExe taplo;
      typescript-language-server.command = lib.getExe typescript-language-server;
      typos.command = lib.getExe typos-lsp;
      vscode-json-language-server.command = lib.getExe vscode-json-languageserver;
    };
    language = [
      {
        name = "astro";
        language-servers = [
          "astro-ls"
          "typos"
        ];
      }
      {
        name = "markdown";
        language-servers = [ "typos" ];
      }
      {
        name = "nix";
        language-servers = [
          "efm-nix"
          # {
          #   name = "efm-nix";
          #   only-features = [ "diagnostics" ];
          # }
          "nil"
          "nixd"
          "typos"
        ];
        formatter.command = lib.getExe nixfmt;
        auto-format = true;
      }
    ];
  },
  helixSettings ? {
    theme = "catppuccin-custom";
    editor = {
      end-of-line-diagnostics = "hint";
      inline-diagnostics.cursor-line = "error";
      rulers = [
        80
        100
        120
      ];
      cursorline = true;
      line-number = "relative";
      shell = [
        (lib.getExe fish)
        "--command"
      ];
      bufferline = "multiple";
      color-modes = true;
      text-width = 120;
      cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      indent-guides.render = true;
      whitespace = {
        render = "all";
        characters.newline = "¬";
      };
      soft-wrap = {
        enable = true;
        wrap-at-text-width = true;
        # wrap-indicator = "≈";
      };
    };
    keys = {
      insert = {
        C-f = "move_char_right";
        C-b = "move_char_left";
        C-p = "move_line_up";
        C-n = "move_line_down";
        C-a = "goto_line_start";
        C-e = "goto_line_end_newline";
        S-tab = "move_parent_node_start";
        "C-[" = "normal_mode";
      };
      normal = {
        X = "extend_line_above";
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        w = "move_next_sub_word_start";
        b = "move_prev_sub_word_start";
        e = "move_next_sub_word_end";
        W = "move_next_word_start";
        B = "move_prev_word_start";
        E = "move_next_word_end";
      };
      select = {
        X = "extend_line_above";
        w = "extend_next_sub_word_start";
        b = "extend_prev_sub_word_start";
        e = "extend_next_sub_word_end";
        W = "extend_next_word_start";
        B = "extend_prev_word_start";
        E = "extend_next_word_end";
      };
      # picker."C-[" = "normal_mode";
    };
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
      --set XDG_CONFIG_HOME "$out/share/config"
  ''
