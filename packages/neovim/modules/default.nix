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

    options = {
      encoding = "utf-8";
      fileencoding = "utf-8";
      fileformats = "unix,dos,mac";
      cmdheight = 0;
      showtabline = 2;
      shiftwidth = 4;
      softtabstop = 4;
      tabstop = 8;
      expandtab = true;
      smarttab = true;
      autoindent = true;
      smartindent = true;
      breakindent = true;
      mouse = "a";
      visualbell = true;
      emoji = true;
      backup = false;
      ignorecase = true;
      smartcase = true;
      ambiwidth = "double";
      shell = "fish";
      swapfile = false;
      termguicolors = true;
      pumblend = 25;
      number = true;
      list = true;
      cursorline = true;
      listchars = {
        space = "･";
        tab = ">-";
        eol = "¬";
        extends = "»";
        precedes = "«";
        nbsp = "+";
      };
      laststatus = 2;
      signcolumn = "yes";
      colorcolumn = [
        80
        100
        120
      ];
      showmatch = true;
      scrolloff = 5;
      relativenumber = true;
    };

    highlight = {
      NormalFloat.bg = "none";
    };

    autoCmd = [
      {
        event = [
          "BufReadPost"
          "BufNewFile"
        ];
        callback.__raw = ''
          function()
            vim.opt_local.formatoptions:remove('r')
            vim.opt_local.formatoptions:remove('o')
          end
        '';
        desc = "Disable automatic comment insertion";
      }
      {
        event = "TermOpen";
        command = "startinsert";
        desc = "Enter insert mode when opening a terminal";
      }
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal shiftwidth=2";
      }
      {
        event = "FileType";
        pattern = "gitcommit";
        callback.__raw = ''
          function()
            vim.opt_local.colorcolumn = { 50, 72 }
            vim.keymap.set('n', '<leader>w', '<cmd>wq<cr>', { buffer = true })
            vim.keymap.set('i', '<C-]>', '<esc><cmd>wq<cr>', { buffer = true })
          end
        '';
      }
      {
        event = "FileType";
        pattern = "markdown";
        callback.__raw = ''
          function()
            vim.opt_local.formatoptions:append('r')
            vim.opt_local.comments = 'b:-,n:>'
          end
        '';
      }
    ];

    keymaps =
      let
        map = key: action: {
          inherit key action;
          mode = "n";
        };
        mode = mode: { inherit mode; };
        options = options: { inherit options; };
      in
      [
        (map "Y" "y$")
        (map "<leader>q" "<cmd>qa<cr>" // options { desc = "Quit all"; })
        (
          map "<c-[>" "<cmd>noh<cr><esc>"
          // mode [
            "n"
            "i"
          ]
        )
        (
          map "gm" "%"
          // mode [
            "n"
            "x"
            "o"
          ]
          // options { desc = "Go to matching bracket"; }
        )
        # disable
        (map "s" "<nop>")
        (map "x" "<nop>")
        # window
        (map "<c-h>" "<c-w>h" // options { remap = true; })
        (map "<c-j>" "<c-w>j" // options { remap = true; })
        (map "<c-k>" "<c-w>k" // options { remap = true; })
        (map "<c-l>" "<c-w>l" // options { remap = true; })
        # register
        (
          map "<leader>y" ''"+y''
          // mode [
            "n"
            "x"
          ]
        )
        (
          map "<leader>Y" ''"+yg_''
          // mode [
            "n"
            "x"
          ]
        )
        (
          map "<leader>d" ''"+d''
          // mode [
            "n"
            "x"
          ]
        )
        (
          map "<leader>p" ''"+p''
          // mode [
            "n"
            "x"
          ]
        )
        (
          map "<leader>0" ''"0p''
          // mode [
            "n"
            "x"
          ]
        )
        (
          map "x" ''"_d''
          // mode [
            "n"
            "x"
          ]
        )
        (
          map "X" ''"_c''
          // mode [
            "n"
            "x"
          ]
        )
        (
          map "j" "gj"
          // mode [
            "n"
            "x"
            "o"
          ]
        )
        (
          map "k" "gk"
          // mode [
            "n"
            "x"
            "o"
          ]
        )
        (
          map "gj" "j"
          // mode [
            "n"
            "x"
            "o"
          ]
        )
        (
          map "gk" "k"
          // mode [
            "n"
            "x"
            "o"
          ]
        )
        (
          map "<a-f>" "<c-g>U<s-right>"
          // mode [
            "i"
            "c"
          ]
        )
        (
          map "<a-b>" "<c-g>U<s-left>"
          // mode [
            "i"
            "c"
          ]
        )
        (
          map "gl" "g_"
          // mode [
            "n"
            "x"
            "o"
          ]
        )
        (
          map "gh" "g^"
          // mode [
            "n"
            "x"
            "o"
          ]
        )
        # indent
        (map "<tab>" "<c-t>" // mode "i")
        (map "<s-tab>" "<c-d>" // mode "i")
        # retain visual selection
        (map ">" ">gv" // mode "v")
        (map "<" "<gv" // mode "v")
        # add undo breakpoints
        (map "," ",<c-g>u" // mode "i")
        (map "." ".<c-g>u" // mode "i")
        (map ";" ";<c-g>u" // mode "i")
        # files
        (map "<leader>s" "<cmd>w<cr><esc>" // options { desc = "Save"; })
        (map "<leader>S" "<cmd>wa<cr><esc>" // options { desc = "Save all"; })
        (map "<leader>q" "<cmd>qa<cr>" // options { desc = "Quit all"; })
        # comments
        (
          map "<leader>c" {
            __raw = ''
              function()
                  local line = vim.api.nvim_get_current_line()
                  local row = unpack(vim.api.nvim_win_get_cursor(0))

                  -- fill to 80 columns
                  local available_width = 80 - #line
                  local comment = string.rep('-', available_width - 1)

                  vim.api.nvim_buf_set_text(0, row - 1, #line, row - 1, #line, { ' ' .. comment })
              end
            '';
          }
          // options { desc = "Line comment"; }
        )
        # emacs keybindings
        (
          map "<c-t>" {
            __raw = ''
              function()
                  local line = vim.api.nvim_get_current_line()
                  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

                  -- is line start or line has only 1 char
                  if col == 0 or #line == 1 then
                      return
                  end

                  -- is line end
                  if col == #line then
                      col = col - 1
                      vim.api.nvim_win_set_cursor(0, { row, col })
                  end

                  local lhs_char = line:sub(col, col)
                  local rhs_char = line:sub(col + 1, col + 1)

                  vim.api.nvim_buf_set_text(0, row - 1, col - 1, row - 1, col + 1, { rhs_char .. lhs_char })
                  vim.api.nvim_win_set_cursor(0, { row, col + 1 })
              end
            '';
          }
          // mode "i"
        )
        (
          map "<c-k>" {
            __raw = ''
              function()
                  local line = vim.api.nvim_get_current_line()
                  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

                  -- is line end
                  if col == #line then
                      return
                  end

                  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, #line, { "" })
              end
            '';
          }
          // mode "i"
        )
        (map "<c-p>" "<c-g>U<up>" // mode "i")
        (map "<c-n>" "<c-g>U<down>" // mode "i")
        (map "<c-f>" "<c-g>U<right>" // mode "i")
        (map "<c-f>" "<right>" // mode "c")
        (map "<c-b>" "<c-g>U<left>" // mode "i")
        (map "<c-b>" "<left>" // mode "c")
        (map "<c-a>" "<c-g>U<home>" // mode "i")
        (map "<c-a>" "<home>" // mode "c")
        (map "<c-e>" "<c-g>U<end>" // mode "i")
        (map "<c-e>" "<end>" // mode "c")
        (
          map "<c-d>" "<del>"
          // mode [
            "i"
            "c"
          ]
        )
        (map "<c-h>" "<bs>" // mode "c")
        # plugins
        (map "<leader>;t" "<cmd>Telescope<cr>" // options { desc = "Telescope"; })
        # terminal
        (map "<C-]" "<C-\\\\><C-n>" // mode "t" // options { desc = "Exit terminal mode"; })
      ];
  };
}
