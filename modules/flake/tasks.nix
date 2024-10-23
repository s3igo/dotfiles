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
    in

    {
      flake-root.projectRootFile = "flake.lock"; # Because of `neovim-config` diredtory also has `flake.nix`

      mission-control.scripts = {
        deploy = {
          description = "Deploy system configuration";
          category = "System";
          exec = writeShellApplication {
            name = "deploy";
            runtimeInputs = [ inputs'.nix-darwin.packages.default ];
            text = ''
              darwin-rebuild switch --flake "$(${lib.getExe config.flake-root.package})#$(scutil --get LocalHostName)"
            '';
          };
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
      };

      apps =
        let
          mkApp = drv: {
            type = "app";
            program = lib.getExe drv;
          };
          default = writeShellApplication {
            name = "default";
            runtimeInputs = [ inputs'.nix-darwin.packages.default ];
            text = ''
              darwin-rebuild switch --flake github:s3igo/dotfiles#"''${1:-$(scutil --get LocalHostName)}"
            '';
          };
          clone = writeShellApplication {
            name = "clone";
            runtimeInputs = [ pkgs.git ];
            text = ''
              git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles
            '';
          };
        in
        {
          default = mkApp default;
          clone = mkApp clone;
          deploy = mkApp config.mission-control.scripts.deploy.exec;
        };
    };
}
