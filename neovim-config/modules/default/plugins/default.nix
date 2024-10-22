utils@{ withUtils, ... }:

{
  imports = withUtils utils [
    ./coding.nix
    ./editor
    ./treesitter.nix
    ./lsp.nix
  ];
}
