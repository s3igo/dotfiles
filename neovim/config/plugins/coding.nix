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
      };
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
    nvim-autopairs = {
      enable = true;
      checkTs = true;
      mapCH = true;
    };
    comment.enable = true;
    mini = {
      enable = true;
      modules = {
        ai = {
          n_lines = 500;
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    nvim-surround
    substitute-nvim
    text-case-nvim
  ];

  keymaps = [
    # substitute-nvim
    {
      key = "s";
      action = "<cmd>lua require('substitute').operator()<cr>";
      mode = "n";
    }
    {
      key = "ss";
      action = "<cmd>lua require('substitute').line()<cr>";
      mode = "n";
    }
    {
      key = "S";
      action = "<cmd>lua require('substitute').eol()<cr>";
      mode = "n";
    }
    {
      key = "s";
      action = "<cmd>lua require('substitute').visual()<cr>";
      mode = "x";
    }
  ];

  extraConfigLua = ''
    -- make autopairs work with cmp
    require('cmp').event:on(
      'confirm_done',
      require('nvim-autopairs.completion.cmp').on_confirm_done()
    )

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

    -- nvim-surround
    require('nvim-surround').setup({})

    -- substitute.nvim
    require('substitute').setup({})
  '';

  extraConfigLuaPost = ''
    -- nvim-autopairs
    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')
    local cond = require('nvim-autopairs.conds')

    npairs.add_rules(
      {
        Rule('{', '}', 'nix')
          :use_key('<tab>')
          :replace_endpair(function() return '<del>};<left><left>' end, true)
      },
      {
        Rule('[', ']', 'nix')
          :use_key('<tab>')
          :replace_endpair(function() return '<del>];<left><left>' end, true)
      }
      -- FIXME: this doesn't work
      -- {
      --   Rule("\'\'", "", "nix")
      --     :use_key('<tab>')
      --     :replace_endpair(function() return '<del>\'\'<left><left>' end)
      -- }
    )
  '';
}
