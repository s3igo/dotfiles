{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.nightfly
    (import ./im-select-nvim.nix { inherit pkgs; })
  ];

  extraConfigLuaPre = ''
    vim.g.nightflyTransparent = true
    vim.g.nightflyVirtualTextColor = true
    vim.g.nightflyWinSeparator = 2
    vim.cmd('colorscheme nightfly')
  '';

  extraConfigLuaPost = ''
    -- im-select
    require('im_select').setup({
      set_previous_events = {},
    })
  '';
}
