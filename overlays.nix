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
      jisyo-list = [
        "SKK-JISYO.L"
        "SKK-JISYO.jinmei"
        "SKK-JISYO.fullname"
        "SKK-JISYO.geo"
        "SKK-JISYO.propernoun"
        "SKK-JISYO.station"
        "SKK-JISYO.assoc"
        "SKK-JISYO.edict"
        "SKK-JISYO.edict2"
        "SKK-JISYO.zipcode"
        "SKK-JISYO.office.zipcode"
        "SKK-JISYO.JIS2"
        "SKK-JISYO.JIS3_4"
        "SKK-JISYO.JIS2004"
        "SKK-JISYO.itaiji"
        "SKK-JISYO.itaiji.JIS3_4"
        "SKK-JISYO.mazegaki"
      ];
    };
  })
]
