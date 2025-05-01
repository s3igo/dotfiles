{
  imports = [ ./deno.nix ];

  plugins.lsp.servers.denols.rootMarkers = [
    {
      __raw = ''
        vim.fs.root(0, function(name, path)
          return name:match('%.[jt]sx?$') ~= nil
        end)
      '';
    }
  ];
}
