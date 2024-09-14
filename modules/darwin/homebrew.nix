{
  user,
  nix-homebrew,
  homebrew-core,
  homebrew-cask,
  homebrew-bundle,
  macos-fuse-t-cask,
  ...
}:

{
  imports = [ nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    enable = true;
    inherit user;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "macos-fuse-t/homebrew-cask" = macos-fuse-t-cask;
    };
    mutableTaps = false;
  };
}
