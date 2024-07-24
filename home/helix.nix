{ user, ... }:

{
  programs.helix = {
    enable = true;
    languages.language = [
      {
        name = "c";
        file-types = [
          "c"
          "h"
        ];
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
      {
        name = "yaml";
        file-types = [
          "yaml"
          "yml"
        ];
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
      {
        name = "dockerfile";
        file-types = [
          "Dockerfile"
          "dockerfile"
        ];
        indent = {
          tab-width = 4;
          unit = "  ";
        };
        comment-token = "#";
      }
      {
        name = "lua";
        indent = {
          tab-width = 4;
          unit = "    ";
        };
      }
    ];
    settings = {
      theme = "catppuccin_mocha_transparent";
      editor = {
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
          "/etc/profiles/per-user/${user}/bin/fish"
          "-c"
        ];
        bufferline = "multiple";
        color-modes = true;
        text-width = 120;
        statusline = {
          left = [
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right =
            let
              default = [
                "diagnostics"
                "selections"
                "register"
                "position"
                "file-encoding"
              ];
            in
            default
            ++ [
              "file-line-ending"
              "file-type"
            ];
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        file-picker.hidden = false;
        indent-guides = {
          render = true;
          character = "|";
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
          C-p = "move_line_up";
          C-n = "move_line_down";
          C-b = "move_char_left";
          C-f = "move_char_right";
          C-a = "goto_line_start";
          C-e = "goto_line_end_newline";
          S-tab = "move_parent_node_start";
        };
        normal = {
          X = "extend_line_above";
          tab = "move_parent_node_end";
          S-tab = "move_parent_node_start";
          "{" = "goto_prev_paragraph";
          "}" = "goto_next_paragraph";
          space = {
            q = ":quit";
            w = ":buffer-close";
            t = "symbol_picker";
            T = "workspace_symbol_picker";
            s = ":update";
            S = "no_op";
            f = ":format";
            F = "no_op";
            o = "file_picker_in_current_buffer_directory";
            space = "file_picker";
            ret = "file_picker_in_current_directory";
          };
        };
        select = {
          tab = "extend_parent_node_end";
          S-tab = "extend_parent_node_start";
        };
      };
    };
    themes =
      let
        mkTransparentTheme = name: {
          inherits = name;
          "ui.background" = "none";
        };
        themes = [
          "kanagawa"
          "snazzy"
          "jetbrains_dark"
          "catppuccin_mocha"
        ];
        transparentThemes = builtins.listToAttrs (
          map (theme: {
            name = "${theme}_transparent";
            value = mkTransparentTheme theme;
          }) themes
        );
      in
      transparentThemes;
  };

  xdg.configFile = {
    "helix/ignore".text = ''
      # Nix
      .direnv/
      result
    '';
  };
}
