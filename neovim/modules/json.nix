{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      json
      json5
      regex
    ];
    lsp.servers.jsonls.enable = true;
  };
}
