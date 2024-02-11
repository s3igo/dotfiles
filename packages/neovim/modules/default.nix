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

    highlight = {
      NormalFloat.bg = "none";
    };

    options = import ./options.nix;
    autoCmd = import ./autocmd.nix;
    keymaps = import ./keymaps.nix;
  };
}
