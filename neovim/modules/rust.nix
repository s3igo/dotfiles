{ pkgs, ... }:

{
  imports = [ ./toml.nix ];

  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
      regex
    ];
    lsp.servers.rust-analyzer = {
      enable = true;
      installCargo = false;
      installRustc = false;
      settings = {
        check.command = "clippy";
        files.excludeDirs = [ ".direnv" ];
      };
    };
  };
}
