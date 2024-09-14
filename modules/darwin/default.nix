{ user, ... }:

{
  imports = [
    ../secrets.nix
    ../system.nix
    ../apps.nix
    ./homebrew.nix
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

  users.users.${user} = {
    name = user;
    home = "/Users/${user}";
    # shell = pkgs.zsh;
  };

}
