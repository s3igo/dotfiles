{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
      toml
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
