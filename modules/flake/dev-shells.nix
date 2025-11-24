{
  perSystem =
    {
      pkgs,
      config,
      ...
    }:

    {
      devShells.default = pkgs.mkShellNoCC {
        inputsFrom = [ config.mission-control.devShell ];
        packages = [
          pkgs.nil
          pkgs.nixd
          pkgs.nixfmt
        ];
      };
    };
}
