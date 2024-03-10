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
    none-ls = {
      enable = true;
      sources.formatting.prettier = {
        enable = true;
        disableTsServerFormatter = true;
      };
    };
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
  };
}
