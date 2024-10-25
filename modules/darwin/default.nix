{
  config,
  pkgs,
  user,
  ...
}:

let
  inherit (config.users.users.${user}) home;
in

{
  imports = [
    ../secrets.nix
    ../system.nix
    ../vim.nix
    ./homebrew.nix
    ./system.nix
    (
      { pkgs, ... }:
      {
        launchd.user.agents.MntR2Crypt = {
          path = with pkgs; [
            rclone
            coreutils
          ];
          environment.RCLONE_CONFIG = config.age.secrets.rclone-config.path;
          script = ''
            mkdir -p ${home}/mnt/r2_crypt && rclone mount r2_crypt: ${home}/mnt/r2_crypt \
              -o modules=iconv,from_code=UTF-8,to_code=UTF-8 \
              --vfs-cache-mode full \
              --vfs-cache-max-age 1d
          '';
          serviceConfig = {
            KeepAlive = true;
            RunAtLoad = true;
            StandardOutPath = "${home}/.local/state/mnt/r2_crypt/out.log";
            StandardErrorPath = "${home}/.local/state/mnt/r2_crypt/err.log";
          };
        };
      }
    )
  ];

  fonts.packages = [ pkgs.udev-gothic-nf ];
}
