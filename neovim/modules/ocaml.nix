{ pkgs, ... }:

{
  autoCmd = [
    {
      event = "FileType";
      pattern = "ocaml";
      command = "setlocal shiftwidth=2";
    }
  ];

  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      ocaml
      ocaml_interface
    ];
    lsp.servers.ocamllsp.enable = true;
  };
}
