{
  autoCmd = [
    {
      event = "FileType";
      pattern = "json";
      command = "setlocal shiftwidth=2";
    }
  ];

  plugins.lsp.servers.jsonls = {
    enable = true;
    settings.json.schemas = {
      fileMatch = [ "*.jsonc" ];
      schema.allowTrailingCommas = true;
    };
  };
}
