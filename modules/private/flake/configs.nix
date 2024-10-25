{ inputs, ... }:

{
  imports = [ ../../flake/config-manager.nix ];

  config-manager = {
    base = {
      darwin = ../darwin/configs;
      home = ../home/configs;
    };
    globalArgs = {
      inherit inputs;
    };
    targets = {
      "s3igo@mbp2023" = {
        system = "aarch64-darwin";
        host = "mbp2023";
        user = "s3igo";
      };
    };
  };
}
