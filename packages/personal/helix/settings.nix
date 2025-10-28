{ lib, fish }:

{
  theme = "catppuccin-custom";
  editor = {
    end-of-line-diagnostics = "hint";
    inline-diagnostics.cursor-line = "error";
    rulers = [
      80
      100
      120
    ];
    cursorline = true;
    line-number = "relative";
    shell = [
      (lib.getExe fish)
      "--command"
    ];
    bufferline = "multiple";
    color-modes = true;
    text-width = 120;
    cursor-shape = {
      normal = "block";
      insert = "bar";
      select = "underline";
    };
    indent-guides.render = true;
    whitespace = {
      render = "all";
      characters.newline = "¬";
    };
    soft-wrap = {
      enable = true;
      wrap-at-text-width = true;
      # wrap-indicator = "≈";
    };
  };
  keys = {
    insert = {
      C-f = "move_char_right";
      C-b = "move_char_left";
      C-p = "move_line_up";
      C-n = "move_line_down";
      C-a = "goto_line_start";
      C-e = "goto_line_end_newline";
      S-tab = "move_parent_node_start";
      "C-[" = "normal_mode";
      A-i = "completion";
    };
    normal = {
      X = "extend_line_above";
      "{" = "goto_prev_paragraph";
      "}" = "goto_next_paragraph";
      w = "move_next_sub_word_start";
      b = "move_prev_sub_word_start";
      e = "move_next_sub_word_end";
      W = "move_next_word_start";
      B = "move_prev_word_start";
      E = "move_next_word_end";
    };
    select = {
      X = "extend_line_above";
      w = "extend_next_sub_word_start";
      b = "extend_prev_sub_word_start";
      e = "extend_next_sub_word_end";
      W = "extend_next_word_start";
      B = "extend_prev_word_start";
      E = "extend_next_word_end";
    };
    # picker."C-[" = "normal_mode";
  };
}
