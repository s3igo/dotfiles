{ pkgs, ... }:
{
  plugins = {
    lsp.keymaps = {
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
      lspBuf = {
        "<leader>r" = {
          action = "rename";
          desc = "Rename symbol";
        };
        "<leader>f" = {
          action = "format";
          desc = "Format buffer";
        };
        K = "hover";
        gK = {
          action = "signature_help";
          desc = "Show signature help";
        };
        gr = {
          action = "references";
          desc = "Show references";
        };
        gd = {
          action = "definition";
          desc = "Go to definition";
        };
        gD = {
          action = "declaration";
          desc = "Go to declaration";
        };
        gI = {
          action = "implementation";
          desc = "Go to implementation";
        };
        gy = {
          action = "type_definition";
          desc = "Go to type definition";
        };
        gs = {
          action = "workspace_symbol";
          desc = "Search workspace symbols";
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
    # actions-preview.nvim
    {
      key = "<leader>a";
      action = "<cmd>lua require('actions-preview').code_actions()<cr>";
      mode = "n";
      options.desc = "Code Actions Preview";
    }
  ];
}
