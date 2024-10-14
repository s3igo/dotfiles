{
  autoCmd = [
    {
      event = "FileType";
      pattern = "ocaml";
      command = "setlocal shiftwidth=2";
    }
  ];

  plugins.lsp.servers.ocamlls = {
    enable = true;
    package = null;
  };
}
