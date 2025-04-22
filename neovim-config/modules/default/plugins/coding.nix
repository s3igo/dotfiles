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
          "<a-I>" = [
            "show_signature"
            "hide_signature"
          ];
          "<c-s>" = [
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
    nvim-surround.enable = true;
    autoclose.enable = true;
  };
}
