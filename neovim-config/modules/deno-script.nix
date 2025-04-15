{
  imports = [ ./deno.nix ];

  plugins.lsp.servers.denols.rootDir = "function() return '' end";
}
