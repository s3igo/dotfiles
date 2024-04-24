{
  inputs.nixvim.url = "github:nix-community/nixvim";

  outputs =
    { nixvim, ... }:
    {
      withModules = import ./. { inherit nixvim; };
      modules = import ./modules { inherit nixvim; };
      # NOTE: `nixosModules` is deprecated
      nixosModules = {
        full = ./modules/full.nix;
        im-select = ./modules/im-select.nix;
        lua = ./modules/lua.nix;
        nix = ./modules/nix.nix;
        rust = ./modules/rust.nix;
        typescript = ./modules/typescript.nix;
        json = ./modules/json.nix;
        markdown = ./modules/markdown.nix;
        prettier = ./modules/prettier.nix;
        yaml = ./modules/yaml.nix;
      };
    };
}
