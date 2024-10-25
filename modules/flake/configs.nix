{ inputs, withSystem, ... }:

{

  flake = {
    darwinConfigurations = {
      mbp2023 =
        let
          user = "s3igo";
          system = "aarch64-darwin";
        in
        withSystem system (
          _:
          inputs.nix-darwin.lib.darwinSystem {
            specialArgs = {
              inherit
                inputs
                user
                system
                ;
            };
            modules = [
              (
                { pkgs, ... }:
                {
                  users.users.${user} = {
                    name = user;
                    home = "/Users/${user}";
                    # shell = pkgs.zsh;
                  };
                }
              )
              ../darwin
            ];
          }
        );
    };
  };
}
