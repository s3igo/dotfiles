{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      lua
      luadoc
      lua_patterns
    ];
    lsp = {
      enable = true;
      servers.lua-ls = {
        enable = true;
        onAttach.function = ''
          client.server_capabilities.documentFormattingProvider = false
        '';
      };
    };
    none-ls = {
      enable = true;
      sources.formatting.stylua.enable = true;
    };
  };
}
