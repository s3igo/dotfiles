{
  outputs =
    _:
    let
      names = [
        "deno-script"
        "json"
        "lua"
        "markdown"
        "nix"
        "ocaml"
        "prettier"
        "rust"
        "toml"
        "typescript"
        "yaml"
      ];
    in
    {
      nixosModules = (import ./modules { inherit names; }) // {
        default = ./core;
      };

      lib.customName =
        {
          pkgs,
          nvim,
          name ? "neovim",
        }:
        pkgs.runCommand "nixvim"
          {
            meta = nvim.meta // {
              mainProgram = name;
            };
          }
          ''
            mkdir -p $out/bin
            ln -s ${pkgs.lib.getExe nvim} $out/bin/${name}
          '';
    };
}
