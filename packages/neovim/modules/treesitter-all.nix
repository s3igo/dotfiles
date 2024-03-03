{ pkgs, ... }:
{
  plugins.treesitter = {
    ensureInstalled = "all";
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
  };
}
