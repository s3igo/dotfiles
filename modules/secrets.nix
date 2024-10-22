{
  user,
  system,
  inputs,
  ...
}:

let
  inherit (inputs) agenix secrets;
in

{
  imports = [ agenix.darwinModules.default ];

  environment.systemPackages = [ agenix.packages.${system}.default ];

  age = {
    identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets =
      let
        rootReadable = {
          mode = "0400";
          owner = "root";
        };
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
        } // userReadable;

        attic-token = {
          file = "${secrets}/config/attic.age";
        } // rootReadable;

        aider-anthropic = {
          file = "${secrets}/config/aider-anthropic.age";
        } // userReadable;
      };
  };
}
