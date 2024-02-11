{ pkgs, ... }:
{
  plugins = {
    nvim-tree = {
      enable = true;
      # FIXME: This is not working
      # filters.cumsom = [ "^\\.git$" ];
      git.ignore = false;
    };
    gitsigns = {
      enable = true;
      currentLineBlame = true;
      signs = {
        add.text = "|";
        change.text = "|";
        delete.text = "_";
        topdelete.text = "‾";
        changedelete.text = "~";
        untracked.text = "?";
      };
      onAttach.function = ''
        function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          map('n', ']g', gs.next_hunk, { desc = 'Next hunk' })
          map('n', '[g', gs.prev_hunk, { desc = 'Previous hunk' })
          map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview hunk' })
          map('n', '<leader>gr', gs.reset_hunk, { desc = 'Reset hunk' })
          map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
          map('n', '<leader>gs', gs.stage_hunk, { desc = 'Stage hunk' })
          map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
          map('n', '<leader>gt', gs.toggle_deleted, { desc = 'Toggle deleted' })
          map({ 'o', 'x' }, 'ih', ':<c-u>Gitsigns select_hunk<cr>', { desc = 'inside hunk' })
        end
      '';
    };
    nvim-colorizer.enable = true;
    mini = {
      enable = true;
      modules = {
        bufremove = { };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    fzf-lua
    nvim-hlslens
    nvim-scrollbar
  ];

  extraPackages = with pkgs; [
    fd
    ripgrep
    fzf
    bat
  ];

  extraConfigLuaPost = ''
    -- fzf-lua
    require('fzf-lua').setup({ 'fzf-native' })
    -- nvim-hlslens
    require('hlslens').setup()
    vim.keymap.set(
      'n',
      'n',
      "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>"
    )
    vim.keymap.set(
      'n',
      'N',
      "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr>"
    )
    vim.keymap.set('n', '*', "*<cmd>lua require('hlslens').start()<cr>")
    vim.keymap.set('n', '#', "#<cmd>lua require('hlslens').start()<cr>")
    vim.keymap.set('n', 'g*', "g*<cmd>lua require('hlslens').start()<cr>")
    vim.keymap.set('n', 'g#', "g#<cmd>lua require('hlslens').start()<cr>")
    -- nvim-scrollbar
    require('scrollbar').setup({
      handle = { color = '#1d3b53' },
      marks = { Search = { color = '#ecc48d' } },
    })
    require('scrollbar.handlers.gitsigns').setup()
    require('scrollbar.handlers.search').setup()
    -- mini.bufremove
    vim.keymap.set(
      'n',
      '<leader>w',
      function() require('mini.bufremove').delete(0, false) end,
      { desc = 'Delete buffer' }
    )
  '';

  keymaps = [
    # nvim-tree
    {
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<cr>";
      mode = "n";
      options.desc = "Toggle NvimTree";
    }
    {
      key = "<leader>o";
      action = "<cmd>NvimTreeFindFile<cr>";
      mode = "n";
      options.desc = "Open the currently open file in NvimTree";
    }
    # fzf-lua
    {
      key = "<leader><space>";
      action = "<cmd>lua require('fzf-lua').files()<cr>";
      mode = "n";
      options.desc = "Fuzzy find files";
    }
    {
      key = "<leader><tab>";
      action = "<cmd>lua require('fzf-lua').buffers()<cr>";
      mode = "n";
      options.desc = "Fuzzy find buffers";
    }
    {
      key = "<leader>/";
      action = "<cmd>lua require('fzf-lua').live_grep()<cr>";
      mode = "n";
      options.desc = "Fuzzy find live grep";
    }
    {
      key = "<leader>:";
      action = "<cmd>lua require('fzf-lua').commands()<cr>";
      mode = "n";
      options.desc = "Fuzzy find commands";
    }
    {
      key = "<leader>'";
      action = "<cmd>lua require('fzf-lua').registers()<cr>";
      mode = "n";
      options.desc = "Fuzzy find registers";
    }
  ];
}
