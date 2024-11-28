{ inputs, ... }:

{
  imports = [
    inputs.mission-control.flakeModule
    inputs.flake-root.flakeModule
    ./apps.nix
    ./development.nix
    ./ime.nix
    ./system.nix
  ];

  perSystem = {
    # Use flake.lock instead of the default flake.nix
    # since both the project root and neovim-config directory contain flake.nix
    flake-root.projectRootFile = "flake.lock";
  };
}
