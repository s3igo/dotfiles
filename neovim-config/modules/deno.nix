{
  imports = [ ./json.nix ];

  plugins = {
    lsp.servers.denols.enable = true;
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
  };
}
