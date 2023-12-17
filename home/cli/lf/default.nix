{ ... }: {
  xdg.configFile."lf/icons".source = ./icons;
  programs.lf = {
    enable = true;
    settings = {
      drawbox = true;
      icons = true;
    };
    commands = {
      open = "$qlmanage -p $f >& /dev/null";
      on-select = ''&{{ lf -remote "send $id set statfmt \"$(eza -ld --color=always "$f")\"" }}'';
      on-quit = ''''${{ echo $PWD > $XDG_DATA_HOME/lf/lastdir }}'';
    };
    keybindings = {
      "<enter>" = "&$OPENER $f";
      o = "$open -a 'Arc.app' $f";
      D = ''
        ''${{
          # DO NOT use the `$fx` variable to distinguish between files containing spaces and multiple files
          if [ -z "$fs" ]; then
              trash "$f"
          else
              trash $fs
          fi
        }}
      '';
    };
  };
}
