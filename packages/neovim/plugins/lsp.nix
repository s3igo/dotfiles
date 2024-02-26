{ pkgs, ... }:
{
  plugins = {
    lsp = {
      # enable = true;
      keymaps = {
        diagnostic = {
          "<leader>." = {
            action = "open_float";
            desc = "Open diagnostic float";
          };
          "]d" = {
            action = "goto_next";
            desc = "Go to next diagnostic";
          };
          "[d" = {
            action = "goto_prev";
            desc = "Go to previous diagnostic";
          };
        };
      };
    };
    fidget = {
      enable = true;
      notification.window.winblend = 0;
    };
  };

  extraPlugins = with pkgs.vimPlugins; [ actions-preview-nvim ];

  keymaps = [
    {
      key = "<leader>i";
      action = "<cmd>LspInfo<cr>";
      mode = "n";
      options.desc = "Show LSP info";
    }
    {
      key = "<leader>r";
      action.__raw = "vim.lsp.buf.rename";
      mode = "n";
      options.desc = "Rename symbol";
    }
    {
      key = "<leader>f";
      action.__raw = "vim.lsp.buf.format";
      mode = "n";
      options.desc = "Format buffer";
    }
    {
      key = "<leader>f";
      action.__raw = ''
        function()
          local start_row, _ = unpack(vim.api.nvim_buf_get_mark(0, '<'))
          local end_row, _ = unpack(vim.api.nvim_buf_get_mark(0, '>'))
          vim.lsp.buf.format({
            range = {
              ['start'] = { start_row, 0 },
              ['end'] = { end_row, 0 },
            },
            async = true,
          })
        end
      '';
      mode = "v";
      options.desc = "Format selection";
    }
    {
      key = "K";
      action.__raw = "vim.lsp.buf.hover";
      mode = "n";
      options.desc = "Show hover information";
    }
    {
      key = "gK";
      action.__raw = "vim.lsp.buf.signature_help";
      mode = "n";
      options.desc = "Show signature help";
    }
    {
      key = "gr";
      action.__raw = "vim.lsp.buf.references";
      mode = "n";
      options.desc = "Show references";
    }
    {
      key = "gd";
      action.__raw = "vim.lsp.buf.definition";
      mode = "n";
      options.desc = "Go to definition";
    }
    {
      key = "gD";
      action.__raw = "vim.lsp.buf.declaration";
      mode = "n";
      options.desc = "Go to declaration";
    }
    {
      key = "gI";
      action.__raw = "vim.lsp.buf.implementation";
      mode = "n";
      options.desc = "Go to implementation";
    }
    {
      key = "gy";
      action.__raw = "vim.lsp.buf.type_definition";
      mode = "n";
      options.desc = "Go to type definition";
    }
    {
      key = "gs";
      action.__raw = "vim.lsp.buf.workspace_symbol";
      mode = "n";
      options.desc = "Search workspace symbols";
    }
    # actions-preview.nvim
    {
      key = "<leader>a";
      action = "<cmd>lua require('actions-preview').code_actions()<cr>";
      mode = "n";
      options.desc = "Code Actions Preview";
    }
  ];
}
