{
  luasnip.enable = true;
  friendly-snippets.enable = true;
  lspkind = {
    enable = true;
    mode = "symbol";
  };
  cmp-nvim-lsp.enable = true;
  cmp-buffer.enable = true;
  cmp-path.enable = true;
  cmp_luasnip.enable = true;
  cmp-cmdline.enable = true;
  nvim-cmp = {
    enable = true;
    snippet.expand = "luasnip";
    mapping = {
      "<c-j>" = ''
        cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
            end
        end)
      '';
      "<c-k>" = ''
        cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end)
      '';
      "<c-d>" = "cmp.mapping.scroll_docs(4)";
      "<c-u>" = "cmp.mapping.scroll_docs(-4)";
      "<tab>" = "cmp.mapping.confirm()";
    };
    sources = [
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "buffer"; }
      { name = "path"; }
    ];
  };
  copilot-lua = {
    enable = true;
    filetypes = {
      txt = false;
      yaml = true;
    };
    extraOptions = {
      suggestion = {
        auto_trigger = true;
        keymap = {
          accept_word = "<c-y>";
          accept_line = "<c-l>";
        };
      };
    };
  };
  nvim-autopairs.enable = true;
  comment-nvim.enable = true;
}
