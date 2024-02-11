{ pkgs, ... }:
{
  config = {
    extraPackages = with pkgs; [
      fd
      ripgrep
    ];

    extraPlugins = with pkgs.vimPlugins; [
      substitute-nvim
      text-case-nvim
    ];

    extraConfigLuaPost = ''
      vim.keymap.set('n', 's', require('substitute').operator)
      vim.keymap.set('n', 'ss', require('substitute').line)
      vim.keymap.set('n', 'S', require('substitute').eol)
      vim.keymap.set('x', 's', require('substitute').visual)
    '';

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
    plugins = import ./plugins;
  };
}
