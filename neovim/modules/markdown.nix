{ pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      markdown
      markdown_inline
      regex
    ];
  };

  highlight = {
    "@markup.list.checked.markdown".link = "NightflyTurquoiseMode";
  };
}
