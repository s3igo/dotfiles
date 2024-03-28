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
    # telescope = {
    #   enable = true;
    # };
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
      window = {
        border = "single";
        winblend = 100;
      };
    };
    smart-splits.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    nightfly
    heirline-nvim
  ];

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

  extraConfigLua = ''
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    local colors = {
      purple = utils.get_highlight('NightflyPurple').fg,
      gray = utils.get_highlight('NightflyAshBlue').fg,
      white = utils.get_highlight('NightflyWhite').fg,
      orange = utils.get_highlight('NightflyTan').fg,
      blue = utils.get_highlight('NightflyBlue').fg,
      green = utils.get_highlight('NightflyEmerald').fg,
      red = utils.get_highlight('NightflyRed').fg,
      navy = '#384b5a',
      bg = '#092236',
    }

    local glyphs = {
      solid_right_arrow = '',
      right_arrow = '',
      solid_left_arrow = '',
      left_arrow = '',
    }

    local spacer = {
      hl = { bg = 'none' },
      provider = '%=',
    }

    local git = {
      condition = conditions.is_git_repo,
      init = function(self)
        self.status = vim.b.gitsigns_status_dict
      end,
      { -- branch
        hl = { fg = colors.white, bg = colors.bg },
        provider = function(self)
          return ' ' .. self.status.head .. ' '
        end,
      },
      { -- separator
        condition = function(self)
          return self.status.added ~= 0
            or self.status.changed ~= 0
            or self.status.removed ~= 0
        end,
        hl = { fg = colors.gray, bg = colors.bg },
        provider = glyphs.right_arrow .. ' ',
      },
      { -- added
        hl = { fg = colors.green, bg = colors.bg },
        provider = function(self)
          local cnt = self.status.added or 0
          return cnt > 0 and '+' .. cnt .. ' '
        end,
      },
      { -- changed
        hl = { fg = colors.orange, bg = colors.bg },
        provider = function(self)
          local cnt = self.status.changed or 0
          return cnt > 0 and '~' .. cnt .. ' '
        end,
      },
      { -- removed
        hl = { fg = colors.red, bg = colors.bg },
        provider = function(self)
          local cnt = self.status.removed or 0
          return cnt > 0 and '-' .. cnt .. ' '
        end,
      },
      {
        hl = { fg = colors.bg, bg = colors.navy },
        provider = glyphs.solid_right_arrow,
      }
    }

    local diagnostics = {
      {
        hl = { bg = colors.navy },
        provider = ' ',
      },
      {
        condition = conditions.has_diagnostics,
        init = function(self)
          self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
          self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,
        update = { 'DiagnosticChanged', 'BufEnter' },
        {
          hl = { fg = colors.red, bg = colors.navy },
          provider = function(self)
            local cnt = self.errors
            return cnt > 0 and 'E:' .. cnt .. ' '
          end,
        },
        {
          hl = { fg = colors.orange, bg = colors.navy },
          provider = function(self)
            local cnt = self.warnings
            return cnt > 0 and 'W:' .. cnt .. ' '
          end,
        },
        {
          hl = { fg = colors.blue, bg = colors.navy },
          provider = function(self)
            local cnt = self.hints
            return cnt > 0 and 'H:' .. cnt .. ' '
          end,
        },
        {
          hl = { fg = colors.gray, bg = colors.navy },
          provider = function(self)
            local cnt = self.info
            return cnt > 0 and 'I:' .. cnt .. ' '
          end,
        },
      },
      {
        hl = { fg = colors.navy, bg = 'none' },
        provider = glyphs.solid_right_arrow,
      },
    }

    local file = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
      { -- filename
        hl = { fg = colors.gray, bg = 'none' },
        provider = function(self)
          local name = vim.fn.fnamemodify(self.filename, ':.')

          if name == "" then return '[No Name]' end

          if not conditions.width_percent_below(#name, 0.25) then
            name = vim.fn.pathshorten(name)
          end

          return ' ' .. name .. ' '
        end,
      },
      { -- flag
        {
          condition = function() return vim.bo.modified end,
          hl = { fg = colors.orange },
          provider = '[+]',
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          hl = { fg = colors.blue },
          provider = '[-]',
        },
      },
    }

    local ruler = {
      {
        hl = { fg = colors.navy, bg = 'none' },
        provider = glyphs.solid_left_arrow,
      },
      {
        hl = { fg = colors.white, bg = colors.navy },
        provider = ' %02c ' .. glyphs.left_arrow .. ' %03l/%03L (%P) '
      },
    }

    require('heirline').setup({
      statusline = {
        git,
        diagnostics,
        file,
        spacer,
        ruler,
      },
    })
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
