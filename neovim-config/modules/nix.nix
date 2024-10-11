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
    treesitter.nixvimInjections = true;
    lsp.servers.nil_ls = {
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

  extraPackages = [ pkgs.nixfmt-rfc-style ];
}
