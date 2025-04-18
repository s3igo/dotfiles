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
    lsp.servers.nixd = {
      enable = true;
      settings = {
        nixpkgs.expr = "import <nixpkgs> { }";
        formatting.command = [ "nixfmt" ];
      };
    };
    lsp.servers.nil_ls.enable = true;
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
