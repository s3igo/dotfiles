{
  outputs = _: {
    nixosModules = (import ./modules) // {
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
