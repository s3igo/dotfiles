{ pkgs, ... }:

{
  autoCmd = [
    {
      event = "FileType";
      pattern = "nix";
      command = "setlocal shiftwidth=2";
    }
  ];

  plugins = {
    treesitter = {
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nix
        bash
        regex
      ];
      nixvimInjections = true;
    };
    lsp.servers.nil-ls = {
      enable = true;
      settings.formatting.command = [ "nixfmt" ];
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
