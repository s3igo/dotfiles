_: {
  plugins = {
    lsp.servers.tsserver = {
      enable = true;
      onAttach.function = ''
        client.server_capabilities.documentFormattingProvider = false
      '';
    };
    none-ls = {
      enable = true;
      sources = {
        code_actions.eslint_d.enable = true;
        diagnostics.eslint_d.enable = true;
        formatting = {
          prettierd.enable = true;
          eslint_d.enable = true;
        };
      };
    };
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
  };
}
