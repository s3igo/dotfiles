{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.lf = {
    enable = true;
    settings = {
      drawbox = true;
      icons = true;
    };
    commands = {
      open = "$qlmanage -p $f >& /dev/null";
      on-select = ''&{{ ${pkgs.lf}/bin/lf -remote "send $id set statfmt \"$(${pkgs.eza}/bin/eza -ld --color=always "$f")\"" }}'';
      on-quit = "\${{ echo $PWD > ${config.xdg.dataHome}/lf/lastdir }}";
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
  home.activation.installLfIcons = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    declare TEMPFILE=$(mktemp)
    ${pkgs.curl}/bin/curl \
      --cacert /etc/ssl/certs/ca-certificates.crt \
      -o $TEMPFILE \
      -s https://raw.githubusercontent.com/gokcehan/lf/master/etc/icons.example
    mv $TEMPFILE ${config.xdg.configHome}/lf/icons
  '';
}
