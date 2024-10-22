{
  outputs = _: {
    nixosModules =
      let
        paths = with builtins; attrNames (readDir ./modules);
        toPathAttrs = path: {
          name = builtins.replaceStrings [ ".nix" ] [ "" ] path;
          value = ./modules/${path};
        };
      in
      builtins.listToAttrs (map toPathAttrs paths);

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
