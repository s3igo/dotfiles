_: {
  plugins = {
    fidget = {
      enable = true;
      notification.window.winblend = 0;
    };
  };

  keymaps = [
    {
      key = "<leader>i";
      action = "<cmd>LspInfo<cr>";
      mode = "n";
      options.desc = "Show LSP info";
    }
    {
      key = "<leader>.";
      action = "vim.diagnostic.open_float";
      mode = "n";
      options.desc = "Open diagnostic float";
    }
    {
      key = "<leader>r";
      action = "vim.lsp.buf.rename";
      mode = "n";
      options.desc = "Rename symbol";
    }
    {
      key = "<leader>f";
      action = "vim.lsp.buf.format";
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
      action = "vim.lsp.buf.hover";
      mode = "n";
      options.desc = "Show hover information";
    }
    {
      key = "gK";
      action = "vim.lsp.buf.signature_help";
      mode = "n";
      options.desc = "Show signature help";
    }
    {
      key = "gr";
      action = "vim.lsp.buf.references";
      mode = "n";
      options.desc = "Show references";
    }
    {
      key = "gd";
      action = "vim.lsp.buf.definition";
      mode = "n";
      options.desc = "Go to definition";
    }
    {
      key = "gD";
      action = "vim.lsp.buf.declaration";
      mode = "n";
      options.desc = "Go to declaration";
    }
    {
      key = "gI";
      action = "vim.lsp.buf.implementation";
      mode = "n";
      options.desc = "Go to implementation";
    }
    {
      key = "gy";
      action = "vim.lsp.buf.type_definition";
      mode = "n";
      options.desc = "Go to type definition";
    }
    {
      key = "gs";
      action = "vim.lsp.buf.workspace_symbol";
      mode = "n";
      options.desc = "Search workspace symbols";
    }
    {
      key = "]d";
      action = "vim.diagnostic.goto_next";
      mode = "n";
      options.desc = "Go to next diagnostic";
    }
    {
      key = "[d";
      action = "vim.diagnostic.goto_prev";
      mode = "n";
      options.desc = "Go to previous diagnostic";
    }
  ];
}
