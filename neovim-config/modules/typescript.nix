{
  imports = [ ./json.nix ];

  plugins = {
    lsp.servers.ts-ls.enable = true;
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
  };
}
