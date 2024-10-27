{
  plugins.lsp.servers.jsonls = {
    enable = true;
    settings.json.schemas = {
      fileMatch = [ "*.jsonc" ];
      schema.allowTrailingCommas = true;
    };
  };
}
