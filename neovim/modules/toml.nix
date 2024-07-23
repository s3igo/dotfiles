{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [ toml ];
    lsp.servers.taplo.enable = true;
  };
}
