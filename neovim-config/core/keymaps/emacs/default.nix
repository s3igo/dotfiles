let
  inherit (import ../../../utils.nix) mapMode;
in

{
  keymaps =
    map (mapMode "i") [
      {
        key = "<c-t>";
        action.__raw = builtins.readFile ./transpose.lua;
      }
      {
        key = "<c-k>";
        action.__raw = builtins.readFile ./kill_line.lua;
      }
      {
        key = "<c-f>";
        action = "<c-g>U<right>";
      }
      {
        key = "<c-b>";
        action = "<c-g>U<left>";
      }
      {
        key = "<c-p>";
        action = "<c-g>U<up>";
      }
      {
        key = "<c-n>";
        action = "<c-g>U<down>";
      }
      {
        key = "<c-a>";
        action = "<c-g>U<home>";
      }
      {
        key = "<c-e>";
        action = "<c-g>U<end>";
      }
      {
        key = "<a-f>";
        action = "<c-g>U<s-right>";
      }
      {
        key = "<a-b>";
        action = "<c-g>U<s-left>";
      }
      {
        key = "<c-d>";
        action = "<del>";
      }
    ]
    ++ map (mapMode "c") [
      {
        key = "<c-f>";
        action = "<right>";
      }
      {
        key = "<c-b>";
        action = "<left>";
      }
      {
        key = "<c-a>";
        action = "<home>";
      }
      {
        key = "<c-e>";
        action = "<end>";
      }
      {
        key = "<a-f>";
        action = "<s-right>";
      }
      {
        key = "<a-b>";
        action = "<s-left>";
      }
      {
        key = "<c-d>";
        action = "<del>";
      }
    ];
}
