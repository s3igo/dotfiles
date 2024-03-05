{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      javascript
      jsdoc
      typescript
      tsx
      regex
      json
    ];
    lsp.servers.tsserver.enable = true;
    none-ls = {
      enable = true;
      sources = {
        code_actions.eslint.enable = true;
        diagnostics.eslint.enable = true;
        formatting = {
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
          eslint.enable = true;
        };
      };
    };
    ts-autotag.enable = true;
    ts-context-commentstring.enable = true;
  };
}
