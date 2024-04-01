{
  programs = {
    yazi = {
      enable = true;
      keymap = {
        manager.append_keymap = [
          {
            on = [
              "g"
              "a"
            ];
            run = ''
              shell --block --confirm '
                open -a 'Arc.app' "$@"
              '
            '';
          }
          {
            on = [ "i" ];
            run = ''
              shell --block --confirm '
                qlmanage -p "$1" &> /dev/null
              '
            '';
          }
        ];
      };
    };
    fish.functions.yy = ''
      set tmp (mktemp -t "yazi-cwd.XXXXX")
      yazi $argv --cwd-file="$tmp"
      if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
      end
      rm -f -- "$tmp"
    '';
  };
}
