{ inputs, ... }:

{
  imports = [ ./module.nix ];

  configurations = {
    profiles = {
      darwin = {
        mbp2023.imports = [
          ../../darwin
        ];
      };
      home = {
        s3igo.imports = [
          ../../../home
        ];
      };
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
