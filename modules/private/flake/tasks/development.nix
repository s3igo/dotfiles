{
  perSystem =
    {
      pkgs,
      lib,
      config,
      ...
    }:

    {
      mission-control.scripts = {
        fmt = {
          description = "Format code with treefmt";
          category = "Development";
          exec = config.treefmt.build.wrapper;
        };

        "preview:rio" = {
          description = "Preview rio config";
          category = "Development";
          exec = pkgs.writeShellApplication {
            name = "preview-rio";
            runtimeInputs = with pkgs; [
              nix
              remarshal
              watchexec
            ];
            text = ''
              SOURCE="$(${lib.getExe config.flake-root.package})/home/rio.nix"
              TARGET="$XDG_CONFIG_HOME/rio/config.toml"

              if [ -e "$TARGET" ]; then
                mv "$TARGET" "$TARGET.tmp"
              fi

              trap 'rm "$TARGET"; [ -e "$TARGET.tmp" ] && mv "$TARGET.tmp" "$TARGET"' SIGINT

              watchexec --watch "$SOURCE" -- "nix eval -f $SOURCE --arg pkgs 'import <nixpkgs> { }' programs.rio.settings --json \
                | json2toml \
                | tee $TARGET"
            '';
          };
        };

        "preview:zellij" = {
          description = "Preview zellij config";
          category = "Development";
          exec = pkgs.writeShellApplication {
            name = "preview-rio";
            runtimeInputs = with pkgs; [
              nix
              watchexec
            ];
            text = ''
              SOURCE="$(${lib.getExe config.flake-root.package})/home/zellij.nix"
              TARGET="$XDG_CONFIG_HOME/zellij/config.kdl"

              if [ -e "$TARGET" ]; then
                mv "$TARGET" "$TARGET.tmp"
              fi

              trap 'rm "$TARGET"; [ -e "$TARGET.tmp" ] && mv "$TARGET.tmp" "$TARGET"' SIGINT

              watchexec --watch "$SOURCE" -- "nix eval \
                -f $SOURCE \
                --arg pkgs 'import <nixpkgs> { }' \
                'xdg.configFile.\"zellij/config.kdl\".text' \
                  | xargs -0 printf \
                  | sed 's/^\"//' \
                  | tee $TARGET"
            '';
          };
        };
      };
    };
}
