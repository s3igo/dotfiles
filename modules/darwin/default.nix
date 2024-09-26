{ user, ... }:

{
  imports = [
    ../secrets.nix
    ../system.nix
    ../vim.nix
    ./homebrew.nix
    ./home-manager.nix
    ./system.nix
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
    home = "/Users/${user}";
    # shell = pkgs.zsh;
  };
}
