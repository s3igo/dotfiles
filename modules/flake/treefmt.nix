{ inputs, ... }:

{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { config, ... }:
    {
      treefmt = {
        inherit (config.flake-root) projectRootFile;
        programs = {
          deadnix.enable = true;
          nixfmt.enable = true;
          statix.enable = true;
          typos.enable = true;
          yamlfmt.enable = true;
        };
        settings.global.excludes = [ "LICENSE" ];
      };

      formatter = config.treefmt.build.wrapper;
    };
}
