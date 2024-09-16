{
  user,
  inputs,
  ...
}:

{
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    enable = true;
    inherit user;
    taps = with inputs; {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "macos-fuse-t/homebrew-cask" = macos-fuse-t-cask;
    };
    mutableTaps = false;
  };
}
