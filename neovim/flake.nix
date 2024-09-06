{
  inputs.nixvim.url = "github:nix-community/nixvim";

  outputs =
    { nixvim, ... }:
    {
      withModules = import ./. { inherit nixvim; };
      modules = import ./modules { inherit nixvim; };
    };
}
