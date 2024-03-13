{ pkgs, ... }:
{
  plugins = {
    nvim-tree = {
      enable = true;
      filters.custom = [ "^\\.git$" ];
      git.ignore = false;
    };
    gitsigns = {
      enable = true;
      currentLineBlame = true;
      signs = {
        add.text = "|";
        change = {
          text = "|";
          hl = "NightflyYellow";
        };
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
    fzf-lua = {
      enable = true;
      settings = {
        keymap.fzf = {
          ctrl-u = "half-page-up";
          ctrl-d = "half-page-down";
          ctrl-f = "forward-char";
          ctrl-b = "backward-char";
          ctrl-k = "kill-line";
        };
        files = {
          rg_opts = pkgs.lib.concatStringsSep " " [
            "--color never --files --hidden --follow --glob '!.git'" # default opts
            "--glob '!node_modules'"
            "--glob '!target'"
            "--glob '!result'"
          ];
          fd_opts = pkgs.lib.concatStringsSep " " [
            "--color never --type file --hidden --follow --exclude .git" # default opts
            "--exclude node_modules"
            "--exclude target"
            "--exclude result"
          ];
        };
      };
    };
    mini = {
      enable = true;
      modules = {
        bufremove = { };
      };
    };
    bufferline = {
      enable = true;
      numbers = "ordinal";
      indicator.icon = "|";
      modifiedIcon = "[+]";
      showBufferIcons = false;
      showBufferCloseIcons = false;
      showCloseIcon = false;
      diagnostics = "nvim_lsp";
      separatorStyle.__raw = "{ '', '' }";
      alwaysShowBufferline = false;
      offsets = [
        {
          filetype = "NvimTree";
          text_align = "left";
          separator = true;
        }
      ];
    };
    indent-blankline = {
      enable = true;
      indent = {
        char = "|";
        highlight = "Indent";
      };
      whitespace.highlight = "Whitespace";
      scope.enabled = false;
    };
    which-key = {
      enable = true;
      window = {
        border = "single";
        winblend = 100;
      };
    };
    smart-splits.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [ nightfly ];

  highlight = {
    NonText.link = "NightflyPickleBlue";
    Whitespace.link = "NightflyPickleBlue";
    SpecialKey.link = "NightflyPickleBlue";
    Indent.link = "NightflyGreyBlue";
    TrailingSpace.link = "NightflyPurpleMode";
  };

  extraPackages = with pkgs; [
    fd
    ripgrep
    fzf
    bat
  ];

  extraConfigLuaPre = ''
    -- nightfly
    vim.g.nightflyTransparent = true
    vim.g.nightflyVirtualTextColor = true
    vim.g.nightflyWinSeparator = 2
    vim.cmd('colorscheme nightfly')
  '';

  keymaps = [
    # mini.bufremove
    {
      key = "<leader>w";
      action = "<cmd>lua require('mini.bufremove').delete()<cr>";
      mode = "n";
      options.desc = "Delete buffer";
    }
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
      key = "<leader>m";
      action = "<cmd>lua require('fzf-lua').files({ cmd = 'git ls-files --modified' })<cr>";
      mode = "n";
      options.desc = "Fuzzy find modified files";
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
    # bufferline
    {
      key = "[b";
      action = "<cmd>BufferLineCyclePrev<cr>";
      mode = "n";
      options.desc = "Previous buffer";
    }
    {
      key = "]b";
      action = "<cmd>BufferLineCycleNext<cr>";
      mode = "n";
      options.desc = "Next buffer";
    }
    {
      key = "<b";
      action = "<cmd>BufferLineMovePrev<cr>";
      mode = "n";
      options.desc = "Move buffer to previous position";
    }
    {
      key = ">b";
      action = "<cmd>BufferLineMoveNext<cr>";
      mode = "n";
      options.desc = "Move buffer to next position";
    }
    # smart-splits
    {
      key = "<c-h>";
      action = "<cmd>lua require('smart-splits').move_cursor_left()<cr>";
      mode = "n";
    }
    {
      key = "<c-j>";
      action = "<cmd>lua require('smart-splits').move_cursor_down()<cr>";
      mode = "n";
    }
    {
      key = "<c-k>";
      action = "<cmd>lua require('smart-splits').move_cursor_up()<cr>";
      mode = "n";
    }
    {
      key = "<c-l>";
      action = "<cmd>lua require('smart-splits').move_cursor_right()<cr>";
      mode = "n";
    }
    {
      key = "<a-h>";
      action = "<cmd>lua require('smart-splits').resize_left()<cr>";
      mode = "n";
    }
    {
      key = "<a-j>";
      action = "<cmd>lua require('smart-splits').resize_down()<cr>";
      mode = "n";
    }
    {
      key = "<a-k>";
      action = "<cmd>lua require('smart-splits').resize_up()<cr>";
      mode = "n";
    }
    {
      key = "<a-l>";
      action = "<cmd>lua require('smart-splits').resize_right()<cr>";
      mode = "n";
    }
    {
      key = "<leader>h";
      action = "<cmd>lua require('smart-splits').swap_buf_left()<cr>";
      mode = "n";
    }
    {
      key = "<leader>j";
      action = "<cmd>lua require('smart-splits').swap_buf_down()<cr>";
      mode = "n";
    }
    {
      key = "<leader>k";
      action = "<cmd>lua require('smart-splits').swap_buf_up()<cr>";
      mode = "n";
    }
    {
      key = "<leader>l";
      action = "<cmd>lua require('smart-splits').swap_buf_right()<cr>";
      mode = "n";
    }
  ];
}
