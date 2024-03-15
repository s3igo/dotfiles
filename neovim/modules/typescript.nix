{ pkgs, ... }:

{
  imports = [ ./json.nix ];

  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      jsdoc
      typescript
      tsx
      regex
    ];
    lsp.servers.tsserver.enable = true;
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
  };
}
