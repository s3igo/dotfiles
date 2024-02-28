_: {
  plugins = {
    lsp = {
      enable = true;
      servers.lua-ls = {
        enable = true;
        onAttach.function = ''
          client.server_capabilities.documentFormattingProvider = false
        '';
      };
    };
    none-ls = {
      enable = true;
      sources.formatting.stylua.enable = true;
    };
  };
}
