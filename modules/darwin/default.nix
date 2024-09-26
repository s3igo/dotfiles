{ config, user, ... }:

let
  home = "/Users/${user}";
in

{
  imports = [
    ../secrets.nix
    ../system.nix
    ../vim.nix
    ./homebrew.nix
    ./home-manager.nix
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
    # (
    #   { pkgs, ... }:
    #   {
    #     nixpkgs.overlays = overlays;
    #     launchd.user.agents.yaskkserv2 = {
    #       path = [ pkgs.yaskkserv2 ];
    #       command = "yaskkserv2 --no-daemonize --midashi-utf8 -- ${pkgs.yaskkserv2-dict}/share/dictionary.yaskkserv2";
    #       serviceConfig = {
    #         KeepAlive = true;
    #         RunAtLoad = true;
    #         StandardOutPath = "/Users/${user}/.local/state/yaskkserv2/out.log";
    #         StandardErrorPath = "/Users/${user}/.local/state/yaskkserv2/err.log";
    #       };
    #     };
    #   }
    # )
  ];

  # system.activationScripts.mnt.text = ''
  #   echo "Mounting ramdisk..." >&2
  #   mkdir -p /Users/${user}/mnt/ramdisk
  # '';

  # environment.extraSetup = ''
  #   echo "Mounting ramdisk..."
  #   mkdir -p /Users/${user}/mnt/ramdisk
  # '';

  users.users.${user} = {
    name = user;
    inherit home;
    # shell = pkgs.zsh;
  };
}
