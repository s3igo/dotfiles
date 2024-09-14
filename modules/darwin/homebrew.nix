{
  user,
  homebrew-core,
  homebrew-cask,
  homebrew-bundle,
  macos-fuse-t-cask,
  ...
}:

{
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
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
