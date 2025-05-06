{
  plugins = {
    lsp.servers.yamlls = {
      enable = true;
      settings.schemas = {
        "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*.{yml,yaml}";
      };
    };
    none-ls = {
      enable = true;
      sources.diagnostics.actionlint.enable = true;
    };
  };
}
