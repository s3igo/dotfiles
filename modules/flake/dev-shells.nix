{
  perSystem =
    {
      pkgs,
      config,
      neovim-config,
      ...
    }:

    {
      devShells.default = pkgs.mkShellNoCC {
        inputsFrom = [ config.mission-control.devShell ];
        packages = [
          (neovim-config.lib.customName {
            inherit pkgs;
            nvim = config.packages.neovim;
          })
        ];
      };
    };
}
