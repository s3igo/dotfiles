{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      fd
      ripgrep
    ];
    filetype.extension.typ = "typst";
    globals = {
      mapleader = " ";
    };
    options = {
      fileformats = "unix,dos,mac";
      cmdheight = 0;
      showtabline = 2;
      shiftwidth = 4;
      softtabstop = 4;
      tabstop = 8;
      expandtab = true;
      smarttab = true;
      autoindent = true;
      smartindent = true;
      breakindent = true;
      mouse = "a";
      visualbell = true;
      emoji = true;
      backup = false;
      ignorecase = true;
      smartcase = true;
    };
    keymaps = [
      {
        key = "Y";
        action = "y$";
        mode = "n";
        options.desc = "Yank to end of line";
      }
      {
        key = "<leader>q";
        action = "<cmd>qa<cr>";
        mode = "n";
        options.desc = "Quit all";
      }
    ];
  };
}
