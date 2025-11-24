{
  autoCmd = [
    {
      event = "FileType";
      pattern = "ocaml";
      command = "setlocal shiftwidth=2";
    }
  ];

  plugins.lsp.servers.ocamllsp = {
    enable = true;
    package = null;
  };
}
