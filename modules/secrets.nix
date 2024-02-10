{
  pkgs,
  agenix,
  secrets,
  user,
  configHome,
  ...
}:
{
  imports = [ agenix.darwinModules.default ];

  environment.systemPackages = [ agenix.packages.${pkgs.system}.default ];

  age = {
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets =
      let
        # rootReadable = {
        #   mode = "0400";
        #   owner = "root";
        # };
        userReadable = {
          mode = "0400";
          owner = user;
        };
      in
      {
        github-nix-token = {
          file = "${secrets}/github/nix.age";
        } // userReadable;
        rclone-config = {
          file = "${secrets}/config/rclone.age";
          path = "${configHome}/rclone/rclone.conf";
        } // userReadable;
      };
  };
}
