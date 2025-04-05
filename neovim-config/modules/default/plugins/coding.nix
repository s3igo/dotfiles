_:

{
  plugins = {
    luasnip.enable = true;
    friendly-snippets.enable = true;
    cmp-cmdline.enable = true;
    cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        mapping.__raw = ''
          (function()
            local luasnip = require('luasnip')

            return {
              -- Trigger suggest
              ['<a-i>'] = cmp.mapping(function()
                if not cmp.visible() then cmp.complete() end
              end),

              ['<tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                elseif luasnip.locally_jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end),

              ['<s-tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end),

              ['<cr>'] = cmp.mapping(function(fallback)
                if cmp.visible() and cmp.get_selected_entry() then
                  if luasnip.expandable() then
                    luasnip.expand()
                  else
                    cmp.confirm()
                  end
                else
                  fallback()
                end
              end),

              ['<c-d>'] = cmp.mapping.scroll_docs(4),
              ['<c-u>'] = cmp.mapping.scroll_docs(-4),
            }
          end)()
        '';
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

  extraConfigLua = ''
    -- friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    -- LuaSnip
    local vscode_dir = vim.fs.find('.vscode', {
      upward = true,
      type = 'directory',
      path = vim.fn.getcwd(),
      stop = vim.env.HOME,
    })[1]

    if vscode_dir then
      local snippets = vim.fs.find(function(name) return name:match('%.code%-snippets$') end, {
        limit = 10,
        type = 'file',
        path = vscode_dir,
      })
      local loader = require('luasnip.loaders.from_vscode')
      for _, snippet in pairs(snippets) do
        loader.load_standalone({ path = snippet })
      end
    end
  '';
}
