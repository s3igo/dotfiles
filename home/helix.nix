{ pkgs, lib, ... }:

{
  programs.helix = {
    enable = true;
    # package = inputs.helix.packages.${pkgs.system}.default;
    extraPackages = [ pkgs.svelte-language-server ];
    languages = {
      language-server = {
        # lsp-ai = {
        #   command = "lsp-ai";
        #   config = {
        #     memory.file_store = { };
        #     models = model1.model;
        #     inherit (model1) completion;
        #   };
        # };
        nixd.command = lib.getExe pkgs.nixd;
        nil.command = lib.getExe pkgs.nil;
        taplo.command = lib.getExe pkgs.taplo;
        typos.command = lib.getExe pkgs.typos-lsp;
        typescript-language-server.command = lib.getExe pkgs.typescript-language-server;
        vtsls = {
          command = lib.getExe pkgs.vtsls;
          args = [ "--stdio" ];
        };
      };
      language = [
        {
          name = "markdown";
          language-servers = [ "typos" ];
        }
        {
          name = "nix";
          language-servers = [
            "typos"
            "nil"
            "nixd"
          ];
          formatter.command = lib.getExe pkgs.nixfmt;
          auto-format = true;
        }
        # {
        #   name = "typescript";
        #   language-servers = [ "vtsls" ];
        # }
      ];
    };
    settings = {
      theme = "catppuccin-custom";
      editor = {
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "error";
        # true-color = true;
        # undercurl = true;
        rulers = [
          80
          100
          120
        ];
        cursorline = true;
        line-number = "relative";
        shell = [
          (lib.getExe pkgs.fish)
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
        # file-picker.hidden = false;
        indent-guides = {
          render = true;
          # character = "|";
        };
        whitespace = {
          render = "all";
          characters = {
            space = "･";
            nbsp = "+";
            newline = "¬";
            tab = ">";
            tabpad = "-";
          };
        };
        soft-wrap = {
          enable = true;
          wrap-at-text-width = true;
          wrap-indicator = "≈";
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
    };
    themes =
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
      };
    ignores = [
      ".direnv/"
      "result"
      "!.helix/"
      "!.github/"
      "!.gitignore"
      "!.gitattributes"
      "!*.local.*"
      "!*.local/"
    ];
  };
}
