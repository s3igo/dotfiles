{
  imports = [ ./json.nix ];

  plugins = {
    lsp.servers.tsserver.enable = true;
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
  };
}
