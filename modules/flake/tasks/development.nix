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

        "preview:zellij" = {
          description = "Preview zellij config";
          category = "Development";
          exec = pkgs.writeShellApplication {
            name = "preview-zellij";
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
