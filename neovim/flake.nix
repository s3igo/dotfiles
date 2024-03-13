{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    { flake-utils, nixvim, ... }:
    flake-utils.lib.eachDefaultSystem (system: {
      withModules = import ./. { inherit system nixvim; };
    })
    // {
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
