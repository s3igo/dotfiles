_:

{
  plugins = {
    lsp = {
      enable = true;
      servers.typos_lsp.enable = true;
      keymaps = {
        diagnostic = {
          "<leader>." = {
            action = "open_float";
            desc = "Open diagnostic float";
          };
        };
        lspBuf = {
          "<leader>f" = {
            action = "format";
            desc = "Format buffer";
          };
          gd = {
            action = "definition";
            desc = "Go to definition";
          };
          gD = {
            action = "declaration";
            desc = "Go to declaration";
          };
          gy = {
            action = "type_definition";
            desc = "Go to type definition";
          };
        };
      };
    };
    fidget = {
      enable = true;
      settings.notification.window.winblend = 0;
    };
  };
}
