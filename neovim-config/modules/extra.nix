{
  plugins = {
    avante = {
      enable = true;
      settings = {
        auto_suggestions_provider = "copilot";
        claude.api_key_name = "cmd:cat /run/agenix/avante-anthropic";
      };
    };
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
