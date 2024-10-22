{ mapMode, ... }:

{ pkgs, ... }:

{
  plugins = {
    web-devicons.enable = true;
    nvim-tree = {
      enable = true;
      filters.custom = [ "^\\.git$" ];
      git.ignore = false;
    };
    gitsigns = {
      enable = true;
      settings = {
        on_attach = ''
          function(bufnr)
            local gs = require('gitsigns')
            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end
            map('n', ']g', gs.next_hunk, { desc = 'Next hunk' })
            map('n', '[g', gs.prev_hunk, { desc = 'Previous hunk' })
            map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
            map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
            map('v', '<leader>hr', function() gitsigns.reset_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, { desc = 'Reset hunk' })
            map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
            map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
            map('v', '<leader>hs', function() gs.stage_hunk({vim.fn.line('.'), vim.fn.line('v')}) end, { desc = 'Stage hunk' })
            map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
            map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
            map('n', '<leader>ht', gs.toggle_deleted, { desc = 'Toggle deleted' })
            map('n', '<leader>hT', gs.toggle_current_line_blame, { desc = 'Toggle current line blame' })
            map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = 'Blame line' })
            map('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
            map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff this' })
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
        "<leader>g" = {
          action = "git_files";
          options.desc = "Fuzzy find modified files";
        };
        "<leader>d" = {
          action = "diagnostics";
          options.desc = "Fuzzy find diagnostics";
        };
        "<leader>t" = {
          action = "lsp_document_symbols";
          options.desc = "Fuzzy find LSP document symbols";
        };
        "<leader>T" = {
          action = "lsp_workspace_symbols";
          options.desc = "Fuzzy find LSP workspace symbols";
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

  keymaps = map (mapMode "n") [
    # mini.bufremove
    {
      key = "<leader>w";
      action = "<cmd>lua require('mini.bufremove').delete()<cr>";
      options.desc = "Delete buffer";
    }
    # nvim-tree
    {
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<cr>";
      options.desc = "Toggle NvimTree";
    }
    {
      key = "<leader>o";
      action = "<cmd>NvimTreeFindFile<cr>";
      options.desc = "Open the currently open file in NvimTree";
    }
    # smart-splits
    {
      key = "<a-h>";
      action = "<cmd>lua require('smart-splits').resize_left()<cr>";
    }
    {
      key = "<a-j>";
      action = "<cmd>lua require('smart-splits').resize_down()<cr>";
    }
    {
      key = "<a-k>";
      action = "<cmd>lua require('smart-splits').resize_up()<cr>";
    }
    {
      key = "<a-l>";
      action = "<cmd>lua require('smart-splits').resize_right()<cr>";
    }
    {
      key = "<c-w>H";
      action = "<cmd>lua require('smart-splits').swap_buf_left()<cr>";
      options.desc = "Swap buffer to the left";
    }
    {
      key = "<c-w>J";
      action = "<cmd>lua require('smart-splits').swap_buf_down()<cr>";
      options.desc = "Swap buffer down";
    }
    {
      key = "<c-w>K";
      action = "<cmd>lua require('smart-splits').swap_buf_up()<cr>";
      options.desc = "Swap buffer up";
    }
    {
      key = "<c-w>L";
      action = "<cmd>lua require('smart-splits').swap_buf_right()<cr>";
      options.desc = "Swap buffer to the right";
    }
  ];
}
