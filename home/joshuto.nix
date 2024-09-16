{ pkgs, ... }:

let
  package = pkgs.joshuto.overrideAttrs (oldAttrs: {
    passthru.config = pkgs.runCommand "joshuto-config" { } ''
      mkdir -p $out/share
      cp -r ${oldAttrs.src}/config $out/share/
    '';
  });
  config = "${package.passthru.config}/share/config";
  tomlToAttrSet = name: with builtins; fromTOML (readFile "${config}/${name}.toml");
  defaultKeymap = tomlToAttrSet "keymap";
  defaultSettings = tomlToAttrSet "joshuto";
in

{
  programs = {
    joshuto = {
      enable = true;
      inherit package;
      theme = {
        lscolors_enabled = true;
        # tabs.styles.active = {
        #   fg = "black";
        #   bg = "light_blue";
        # };
      };
      settings = defaultSettings // {
        display = {
          show_hidden = true;
          show_icons = true;
        };
      };
      keymap = defaultKeymap // {
        default_view.keymap = defaultKeymap.default_view.keymap ++ [
          {
            keys = [ "o" ];
            commands = [ "shell qlmanage -p %s &> /dev/null" ];
          }
          {
            keys = [
              "b"
              "o"
            ];
            commands = [ "shell open -a 'Arc.app' %s" ];
          }
          {
            keys = [
              "c"
              "l"
            ];
            commands = [ "select --all=true --toggle=false --deselect=true" ];
          }
        ];
      };
    };
    fish.functions.jo = ''
      mkdir -p /tmp/$USER
      set -l output_file "/tmp/$USER/joshuto-cwd-$fish_pid"
      ${package}/bin/joshuto --output-file "$output_file" $argv

      # Whether the output contains the current directory
      if test $status -eq 101
        set -l joshuto_cwd (cat "$output_file")
        cd "$joshuto_cwd"
      end
    '';
  };

  xdg.configFile = {
    "joshuto/icons.toml".source = "${config}/icons.toml";
    "joshuto/preview_file.sh".source = "${config}/preview_file.sh";
  };
}
