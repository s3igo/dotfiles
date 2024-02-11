{
  luasnip.enable = true;
  copilot-lua = {
    enable = true;
    filetypes = {
      txt = false;
      yaml = true;
    };
    extraOptions = {
      suggestion = {
        auto_trigger = true;
        keymap = {
          accept_word = "<c-y>";
          accept_line = "<c-l>";
        };
      };
    };
  };
  nvim-autopairs.enable = true;
  surround.enable = true;
  comment-nvim.enable = true;
}
