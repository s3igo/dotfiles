{ pkgs, ... }:
{
  plugins = {
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
    # leap = {
    #   enable = true;
    #   addDefaultMappings = false;
    # };
  };

  extraPlugins = with pkgs.vimPlugins; [
    nvim-surround
    substitute-nvim
    text-case-nvim
  ];

  keymaps = [
    # leap
    # {
    #   key = "gf";
    #   action = "<plug>(leap-forward-to)";
    #   mode = [
    #     "n"
    #     "x"
    #     "o"
    #   ];
    # }
    # {
    #   key = "gF";
    #   action = "<plug>(leap-backward-to)";
    #   mode = [
    #     "n"
    #     "x"
    #     "o"
    #   ];
    # }
    # {
    #   key = "gt";
    #   action = "<plug>(leap-forward-till)";
    #   mode = [
    #     "n"
    #     "x"
    #     "o"
    #   ];
    # }
    # {
    #   key = "gT";
    #   action = "<plug>(leap-backward-till)";
    #   mode = [
    #     "n"
    #     "x"
    #     "o"
    #   ];
    # }
    # substitute-nvim
    {
      key = "s";
      action.__raw = ''
        function()
          require('substitute').operator()
        end
      '';
      mode = "n";
    }
    {
      key = "ss";
      action.__raw = ''
        function()
          require('substitute').line()
        end
      '';
      mode = "n";
    }
    {
      key = "S";
      action.__raw = ''
        function()
          require('substitute').eol()
        end
      '';
      mode = "n";
    }
    {
      key = "s";
      action.__raw = ''
        function()
          require('substitute').visual()
        end
      '';
      mode = "x";
    }
  ];

  extraConfigLua = ''
    -- nvim-surround
    require('nvim-surround').setup({})

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
