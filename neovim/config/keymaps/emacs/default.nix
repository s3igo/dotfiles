{
  keymaps = [
    {
      key = "<c-t>";
      action.__raw = builtins.readFile ./transpose.lua;
      mode = "i";
    }
    {
      key = "<c-k>";
      action.__raw = builtins.readFile ./kill_line.lua;
      mode = "i";
    }
    {
      key = "<c-p>";
      action = "<c-g>U<up>";
      mode = "i";
    }
    {
      key = "<c-n>";
      action = "<c-g>U<down>";
      mode = "i";
    }
    {
      key = "<c-f>";
      action = "<c-g>U<right>";
      mode = "i";
    }
    {
      key = "<c-f>";
      action = "<right>";
      mode = "c";
    }
    {
      key = "<c-b>";
      action = "<c-g>U<left>";
      mode = "i";
    }
    {
      key = "<c-b>";
      action = "<left>";
      mode = "c";
    }
    {
      key = "<c-a>";
      action = "<c-g>U<home>";
      mode = "i";
    }
    {
      key = "<c-a>";
      action = "<home>";
      mode = "c";
    }
    {
      key = "<c-e>";
      action = "<c-g>U<end>";
      mode = "i";
    }
    {
      key = "<c-e>";
      action = "<end>";
      mode = "c";
    }
    {
      key = "<c-d>";
      action = "<del>";
      mode = [
        "i"
        "c"
      ];
    }
    {
      key = "<c-h>";
      action = "<bs>";
      mode = "c";
    }
    {
      key = "<c-h>";
      action = "<bs>";
      mode = "c";
    }
    {
      key = "<a-f>";
      action = "<c-g>U<s-right>";
      mode = [
        "i"
        "c"
      ];
    }
    {
      key = "<a-b>";
      action = "<c-g>U<s-left>";
      mode = [
        "i"
        "c"
      ];
    }
  ];
}
