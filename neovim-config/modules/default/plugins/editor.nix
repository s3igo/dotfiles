{ mapMode, ... }:

{ pkgs, ... }:

{
  plugins = {
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
    colorizer.enable = true;
    mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        icons = { };
        tabline = { };
      };
    };
    which-key = {
      enable = true;
      settings.win.border = "single";
    };
    smart-splits.enable = true;
    hardtime.enable = true;
    snacks = {
      enable = true;
      settings = {
        indent = {
          animate.enabled = false;
          scope.enabled = false;
        };
        picker = {
          sources.explorer.ignored = true;
          actions = {
            smart_scroll_up.__raw = ''
              function(picker)
                local mode = vim.fn.mode()
                if mode == 'n' then
                  picker:action('list_scroll_up')
                elseif mode == 'i' then
                  picker:action('preview_scroll_up')
                end
              end
            '';
            smart_scroll_down.__raw = ''
              function(picker)
                local mode = vim.fn.mode()
                if mode == 'n' then
                  picker:action('list_scroll_down')
                elseif mode == 'i' then
                  picker:action('preview_scroll_down')
                end
              end
            '';
          };
          win.input.keys = {
            "<c-k>" = "list_up"; # To inherit the behavior of <c-k> in insert mode: kill_line
            "<c-a>" = "select_all"; # To inherit the behavior of <c-a> in insert mode: <home>
            "<c-b>" = "preview_scroll_up"; # To inherit the behavior of <c-b> in insert mode: <left>
            "<c-f>" = "preview_scroll_down"; # To inherit the behavior of <c-f> in insert mode: <right>
            "<c-u>".__raw = "{ 'smart_scroll_up', mode = { 'i', 'n' } }";
            "<c-d>".__raw = "{ 'smart_scroll_down', mode = { 'i', 'n' } }";
          };
        };
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    nightfly
  ];

  highlight = rec {
    NonText.link = "NightflyPickleBlue";
    Whitespace.link = NonText.link;
    SpecialKey.link = NonText.link;
    SnacksIndent.link = NonText.link;
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

  keymaps = map (mapMode "n") [
    # snacks
    {
      key = "<leader>w";
      action = "<cmd>lua Snacks.bufdelete()<cr>";
      options.desc = "Delete buffer";
    }
    {
      key = "<leader><space>";
      action = "<cmd>lua Snacks.picker.files({ hidden = true })<cr>";
      options.desc = "Find files";
    }
    {
      key = "<leader>?";
      action = "<cmd>lua Snacks.picker.files({ hidden = true, ignored = true })<cr>";
      options.desc = "Find including ignored files";
    }
    {
      key = "<leader><tab>";
      action = "<cmd>lua Snacks.picker.buffers()<cr>";
      options.desc = "Buffers";
    }
    {
      key = "<leader>/";
      action = "<cmd>lua Snacks.picker.grep({ hidden = true })<cr>";
      options.desc = "Grep";
    }
    {
      key = "<leader>'";
      action = "<cmd>lua Snacks.picker.registers()<cr>";
      options.desc = "Registers";
    }
    {
      key = "<leader>:";
      action = "<cmd>lua Snacks.picker.command_history()<cr>";
      options.desc = "Command history";
    }
    {
      key = "<leader>p";
      action = "<cmd>lua Snacks.picker.commands()<cr>";
      options.desc = "Commands";
    }
    {
      key = "<leader>d";
      action = "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>";
      options.desc = "Buffer diagnostics";
    }
    {
      key = "<leader>D";
      action = "<cmd>lua Snacks.picker.diagnostics()<cr>";
      options.desc = "Diagnostics";
    }
    {
      key = "<leader>s";
      action = "<cmd>lua Snacks.picker.lsp_symbols()<cr>";
      options.desc = "LSP symbols";
    }
    {
      key = "<leader>S";
      action = "<cmd>lua Snacks.picker.lsp_workspace_symbols()<cr>";
      options.desc = "LSP workspace symbols";
    }
    {
      key = "<leader>g";
      action = "<cmd>lua Snacks.picker.git_status()<cr>";
      options.desc = "Git status";
    }
    {
      key = "<leader>u";
      action = "<cmd>lua Snacks.picker.undo()<cr>";
      options.desc = "Undo history";
    }
    {
      key = "<leader>e";
      action = "<cmd>lua Snacks.explorer()<cr>";
      options.desc = "Toggle explorer";
    }
    {
      key = "<leader>o";
      action = "<cmd>lua Snacks.explorer.reveal()<cr>";
      options.desc = "Open current buffer in explorer";
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
