{
  imports = [ ./json.nix ];

  plugins = {
    lsp.servers.vtsls.enable = true;
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
  };
}
