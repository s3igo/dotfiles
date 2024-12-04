{ inputs, ... }:

{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { config, ... }:
    {
      treefmt = {
        inherit (config.flake-root) projectRootFile;
        programs = {
          nixfmt.enable = true;
          statix.enable = true;
          deadnix.enable = true;
          stylua = {
            enable = true;
            settings = {
              indent_type = "Spaces";
              quote_style = "AutoPreferSingle";
              collapse_simple_statement = "FunctionOnly";
            };
            excludes = [ "neovim-config/*" ];
          };
          yamlfmt.enable = true;
        };
        settings.global.excludes = [
          "README.md"
          "LICENSE"
          ".envrc"
        ];
      };

      formatter = config.treefmt.build.wrapper;
    };
}
