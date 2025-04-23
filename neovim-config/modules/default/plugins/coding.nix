_:

{
  plugins = {
    friendly-snippets.enable = true;
    blink-cmp = {
      enable = true;
      settings = {
        completion = {
          list.selection = {
            auto_insert = false;
            preselect = false;
          };
          documentation.auto_show = true;
          # nvim-highlight-colors
          # https://github.com/brenoprata10/nvim-highlight-colors?tab=readme-ov-file#blinkcmp-integration
          menu.draw.components.kind_icon = {
            text.__raw = ''
              function(ctx)
                local icon = ctx.kind_icon
                if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr ~= "" then
                    icon = color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end
            '';
            highlight.__raw = ''
              function(ctx)
                local highlight = "BlinkCmpKind" .. ctx.kind
                if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item and color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end
                return highlight
              end
            '';
          };
        };
        signature.enabled = true;
        keymap = {
          preset = "none";
          "<a-i>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<c-x><c-e>" = [
            "hide"
            "fallback_to_mappings"
          ];
          "<tab>" = [
            "snippet_forward"
            "select_next"
            "fallback_to_mappings"
          ];
          "<s-tab>" = [
            "snippet_backward"
            "select_prev"
            "fallback_to_mappings"
          ];
          "<cr>" = [
            "accept"
            "fallback"
          ];
          "<c-u>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<c-d>" = [
            "scroll_documentation_down"
            "fallback"
          ];
          "<c-x><c-s>" = [
            "show_signature"
            "hide_signature"
          ];
        };
      };
    };
    copilot-lua = {
      enable = true;
      settings = {
        filetypes = {
          txt = false;
          yaml = true;
          gitcommit = true;
        };
        extraOptions.suggestion = {
          auto_trigger = true;
          keymap = {
            accept_word = "<c-y>";
            accept_line = "<c-l>";
          };
        };
      };
    };
    mini = {
      enable = true;
      luaConfig = {
        pre = "local ai_spec = require('mini.extra').gen_ai_spec";
        # Not using NixVim's built-in keymap to avoid complex handling of escape sequences
        post = ''
          local map_bs = function(lhs, rhs)
            vim.keymap.set('i', lhs, rhs, { expr = true, replace_keycodes = false })
          end
          map_bs('<C-h>', 'v:lua.MiniPairs.bs()')
          map_bs('<C-w>', 'v:lua.MiniPairs.bs("\23")')
          map_bs('<C-u>', 'v:lua.MiniPairs.bs("\21")')
        '';
      };
      modules = {
        pairs = { };
        surround = { };
        ai.custom_textobjects = {
          I.__raw = "ai_spec.indent()";
          L.__raw = "ai_spec.line()";
          N.__raw = "ai_spec.number()";
        };
        extra = { };
      };
    };
  };
}
