{ pkgs, ... }:
{
  extraConfigLuaPost = ''
    -- substiture.nvim
    vim.keymap.set('n', 's', require('substitute').operator)
    vim.keymap.set('n', 'ss', require('substitute').line)
    vim.keymap.set('n', 'S', require('substitute').eol)
    vim.keymap.set('x', 's', require('substitute').visual)

    -- friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load()

    -- LuaSnip
    local vscode_dir = vim.fs.find('.vscode', {
      upward = true,
      type = 'directory',
      path = vim.fn.getcwd(),
      stop = vim.env.HOME,
    })[1]

    if vscode_dir then
      local snippets = vim.fs.find(function(name) return name:match('%.code%-snippets$') end, {
          limit = 10,
          type = 'file',
          path = vscode_dir,
      })
      local loader = require('luasnip.loaders.from_vscode')
      for _, snippet in pairs(snippets) do
          loader.load_standalone({ path = snippet })
      end
    end
  '';

  extraPackages = with pkgs; [
    fd
    ripgrep
  ];

  extraPlugins = with pkgs.vimPlugins; [
    nvim-surround
    substitute-nvim
    text-case-nvim
  ];

  plugins = import ./coding.nix;
}
