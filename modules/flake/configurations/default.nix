{ inputs, ... }:

{
  imports = [ ./module.nix ];

  configurations = {
    base = {
      darwin = ../../private/darwin/configs;
      home = ../../private/home/configs;
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
