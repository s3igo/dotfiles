{
  plugins.lsp.servers.yamlls = {
    enable = true;
    settings.schemas = {
      "https://json.schemastore.org/github-workflow.json" = ".github/workflows/*.{yml,yaml}";
    };
  };
}
