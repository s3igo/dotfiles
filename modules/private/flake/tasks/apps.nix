{
  perSystem =
    {
      pkgs,
      lib,
      config,
      inputs',
      ...
    }:

    let
      mkApp = drv: {
        type = "app";
        program = lib.getExe drv;
      };
    in

    {
      apps = {
        default = mkApp (
          pkgs.writeShellApplication {
            name = "default";
            runtimeInputs = [ inputs'.nix-darwin.packages.default ];
            text = ''
              darwin-rebuild switch --flake github:s3igo/dotfiles#"''${2:-$(whoami)}@''${1:-$(hostname -s)}"
            '';
          }
        );

        clone = mkApp (
          pkgs.writeShellApplication {
            name = "clone";
            runtimeInputs = [ pkgs.git ];
            text = ''
              git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles
            '';
          }
        );

        deploy = mkApp config.mission-control.scripts.deploy.exec;
      };
    };
}
