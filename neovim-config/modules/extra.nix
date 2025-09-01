{
  plugins = {
    copilot-lua = {
      enable = true;
      settings = {
        filetypes = {
          txt = false;
          yaml = true;
          gitcommit = true;
        };
        extraOptions.suggestion = {
          auto_trigger = true;
          keymap = {
            accept_word = "<c-y>";
            accept_line = "<c-l>";
          };
        };
      };
    };
  };
}
