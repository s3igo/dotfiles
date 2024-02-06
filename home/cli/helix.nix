_: {
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
        auto-format = true;
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
      editor = {
        true-color = true;
        undercurl = true;
        rulers = [
          80
          100
          120
        ];
        cursorline = true;
        line-number = "relative";
        shell = [
          "zsh"
          "-c"
        ];
        auto-save = true;
        # bufferline = "always";
        color-modes = true;
        text-width = 120;
        statusline = {
          left = [
            "mode"
            "spinner"
            "spacer"
            "version-control"
            "file-name"
          ];
          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
        lsp.display-inlay-hints = true;
        cursor-shape = {
          insert = "bar";
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
        };
        normal = {
          X = "extend_line_above";
          ";" = "repeat_last_motion";
          "C-;" = "collapse_selection";
          C-k = [
            "goto_line_start"
            "select_mode"
            "goto_line_end"
            "yank"
            "goto_line_start"
            "kill_to_line_end"
            "delete_selection_noyank"
          ];
          space.q = ":buffer-close";
        };
      };
      theme = "kanagawa_transparent";
    };
    themes = {
      kanagawa_transparent = {
        inherits = "kanagawa";
        "ui.background" = "none";
      };
    };
  };
}
