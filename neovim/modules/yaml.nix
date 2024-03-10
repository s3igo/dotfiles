{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      yaml
      regex
    ];
    lsp.servers.yamlls.enable = true;
  };
}
