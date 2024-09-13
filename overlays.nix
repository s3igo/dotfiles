[
  (final: prev: {
    skk-dict = prev.callPackage ./packages/skk-dict.nix { };
  })

  (final: prev: {
    yaskkserv2 = prev.callPackage ./packages/yaskkserv2.nix { };
  })

  (final: prev: {
    yaskkserv2-dict = prev.callPackage ./packages/yaskkserv2-dict.nix {
      inherit (final) skk-dict yaskkserv2;
    };
  })
]
