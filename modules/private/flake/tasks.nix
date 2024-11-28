{ inputs, ... }:

{
  imports = [
    inputs.mission-control.flakeModule
    inputs.flake-root.flakeModule
  ];

  perSystem =
    {
      pkgs,
      lib,
      config,
      inputs',
      self',
      ...
    }:

    let
      target = "~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries";
      inherit (self'.packages) skk-dict;
      inherit (pkgs) writeShellApplication;
      mkApp = drv: {
        type = "app";
        program = lib.getExe drv;
      };
    in

    {
      # Use flake.lock instead of the default flake.nix
      # since both the project root and neovim-config directory contain flake.nix
      flake-root.projectRootFile = "flake.lock";

      mission-control.scripts = {
        deploy = {
          description = "Deploy system configuration";
          category = "System";
          exec = writeShellApplication {
            name = "deploy";
            runtimeInputs = [ inputs'.nix-darwin.packages.default ];
            text = ''
              darwin-rebuild switch --flake "$(${lib.getExe config.flake-root.package})#$(whoami)@$(hostname -s)"
            '';
          };
        };

        fmt = {
          description = "Format code with treefmt";
          category = "Development";
          exec = config.treefmt.build.wrapper;
        };

        wipe-history = {
          description = "Clear profile history for system and home-manager";
          category = "Maintenance";
          exec = ''
            sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
            nix profile wipe-history --profile "$XDG_STATE_HOME/nix/profiles/home-manager"
          '';
        };

        versions = {
          description = "Show system profile version differences";
          category = "System";
          exec = writeShellApplication {
            name = "versions";
            runtimeInputs = [ pkgs.gawk ];
            text = ''
              nix profile diff-closures --profile /nix/var/nix/profiles/system \
                | awk 'BEGIN { RS="" } { par=$0 } END { print par }'
            '';
          };
        };

        install-skk-dicts = {
          description = "Install SKK dictionaries";
          category = "IME";
          exec =
            let
              jisyoList = [
                "SKK-JISYO.L"
                "SKK-JISYO.jinmei"
                "SKK-JISYO.fullname"
                "SKK-JISYO.geo"
                "SKK-JISYO.propernoun"
                "SKK-JISYO.station"
                "SKK-JISYO.assoc"
                "SKK-JISYO.edict"
                # "SKK-JISYO.edict2" # occurs error
                "SKK-JISYO.zipcode"
                "SKK-JISYO.office.zipcode"
                "SKK-JISYO.JIS2"
                # "SKK-JISYO.JIS3_4" # occurs error
                "SKK-JISYO.JIS2004"
                "SKK-JISYO.itaiji"
                "SKK-JISYO.itaiji.JIS3_4"
                "SKK-JISYO.mazegaki"
              ];
              cmd = jisyo: "cp ${skk-dict}/share/${jisyo} ${target}/${jisyo}";
              cmds = map cmd jisyoList;
              script = lib.concatStringsSep "\n" cmds;
            in
            if pkgs.stdenv.isDarwin then script else null;
        };

        cleanup-skk-dicts = {
          description = "Remove installed SKK dictionaries";
          category = "IME";
          exec =
            let
              cmd = jisyo: "rm -f ${target}/${jisyo}";
              cmds = map cmd skk-dict.passthru.list;
              script = lib.concatStringsSep "\n" cmds;
            in
            if pkgs.stdenv.isDarwin then script else null;
        };

        "preview:rio" = {
          description = "Preview rio config";
          category = "Development";
          exec = writeShellApplication {
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
          exec = writeShellApplication {
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

      apps = {
        default = mkApp (writeShellApplication {
          name = "default";
          runtimeInputs = [ inputs'.nix-darwin.packages.default ];
          text = ''
            darwin-rebuild switch --flake github:s3igo/dotfiles#"''${2:-$(whoami)}@''${1:-$(hostname -s)}"
          '';
        });
        clone = mkApp (writeShellApplication {
          name = "clone";
          runtimeInputs = [ pkgs.git ];
          text = ''
            git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles
          '';
        });
        deploy = mkApp config.mission-control.scripts.deploy.exec;
      };
    };
}
