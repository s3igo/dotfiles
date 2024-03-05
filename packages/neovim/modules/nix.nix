{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      nix
      bash
    ];
    lsp = {
      enable = true;
      servers.nil_ls = {
        enable = true;
        settings.formatting.command = [ "nixfmt" ];
      };
    };
    none-ls = {
      enable = true;
      sources = {
        code_actions.statix.enable = true;
        diagnostics.statix.enable = true;
      };
    };
  };

  extraPackages = with pkgs; [ nixfmt-rfc-style ];
}
