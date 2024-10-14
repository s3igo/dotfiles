{
  imports = [ ./toml.nix ];

  plugins.lsp.servers.rust_analyzer = {
    enable = true;
    installCargo = false;
    installRustc = false;
    settings = {
      check.command = "clippy";
      files.excludeDirs = [ ".direnv" ];
    };
  };
}
