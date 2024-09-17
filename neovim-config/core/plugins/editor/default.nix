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
      settings = {
        current_line_blame = true;
        signs = {
          add.text = "|";
          change.text = "|";
          untracked.text = "?";
        };
        on_attach = ''
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
    };
    nvim-colorizer.enable = true;
    telescope = {
      enable = true;
      settings = {
        defaults = {
          mappings.i = {
            "<c-f>" = false;
            "<c-k>" = false;
            "<c-[>".__raw = "require('telescope.actions').close";
          };
          file_ignore_patterns = [
            "^%.git/"
            "^%.direnv/"
            "^node_modules/"
            "^target/"
            "^result/"
          ];
        };
        pickers = {
          find_files.hidden = true;
          live_grep.additional_args = [ "--hidden" ];
          git_files.git_command = [
            "git"
            "ls-files"
            "--modified"
          ];
        };
      };
      keymaps = {
        "<leader><space>" = {
          action = "find_files";
          options.desc = "Fuzzy find files";
        };
        "<leader>/" = {
          action = "live_grep";
          options.desc = "Fuzzy find live grep";
        };
        "<leader>:" = {
          action = "commands";
          options.desc = "Fuzzy find commands";
        };
        "<leader>'" = {
          action = "registers";
          options.desc = "Fuzzy find registers";
        };
        "<leader><tab>" = {
          action = "buffers";
          options.desc = "Fuzzy find buffers";
        };
        "<leader>m" = {
          action = "git_files";
          options.desc = "Fuzzy find modified files";
        };
        "<leader>d" = {
          action = "diagnostics";
          options.desc = "Fuzzy find diagnostics";
        };
      };
    };
    mini = {
      enable = true;
      modules = {
        bufremove = { };
      };
    };
    indent-blankline = {
      enable = true;
      settings = {
        indent = {
          char = "|";
          highlight = "Indent";
        };
        whitespace.highlight = "Whitespace";
        scope.enabled = false;
      };
    };
    which-key = {
      enable = true;
      settings.win.border = "single";
    };
    smart-splits.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    nightfly
    # heirline-nvim
  ];

  highlight = {
    NonText.link = "NightflyPickleBlue";
    Whitespace.link = "NightflyPickleBlue";
    SpecialKey.link = "NightflyPickleBlue";
    Indent.link = "NightflyGreyBlue";
    TrailingSpace.link = "NightflyPurpleMode";
    WhichKeyFloat.bg = "none";
    TabLineFill.bg = "none";
    GitSignsChange.link = "NightflyYellow";
  };

  extraPackages = with pkgs; [
    fd
    ripgrep
  ];

  extraConfigLuaPre = ''
    -- nightfly
    vim.g.nightflyTransparent = true
    vim.g.nightflyVirtualTextColor = true
    vim.g.nightflyWinSeparator = 2
    vim.cmd('colorscheme nightfly')
  '';

  # extraConfigLua = builtins.readFile ./heirline.lua;

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
      options.desc = "Swap buffer to the left";
    }
    {
      key = "<leader>j";
      action = "<cmd>lua require('smart-splits').swap_buf_down()<cr>";
      mode = "n";
      options.desc = "Swap buffer down";
    }
    {
      key = "<leader>k";
      action = "<cmd>lua require('smart-splits').swap_buf_up()<cr>";
      mode = "n";
      options.desc = "Swap buffer up";
    }
    {
      key = "<leader>l";
      action = "<cmd>lua require('smart-splits').swap_buf_right()<cr>";
      mode = "n";
      options.desc = "Swap buffer to the right";
    }
  ];
}
