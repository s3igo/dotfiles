{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      jsdoc
      typescript
      regex
    ];
    lsp.servers.denols = {
      enable = true;
      rootDir = "function() return '' end";
    };
  };
}
