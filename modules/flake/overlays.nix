{
  flake.overlays = {
    joshuto = _final: prev: {
      joshuto = prev.joshuto.overrideAttrs rec {
        version = "0.9.8-unstable-2024-12-14";
        src = prev.fetchFromGitHub {
          owner = "kamiyaa";
          repo = "joshuto";
          rev = "e26204763b3ccd8da02e3b7d3bb6e22ab653d690";
          hash = "sha256-hOoJq/QX2ilX/AF/v0cJtOSv0Z0VIyqWISkJdFPZO38=";
        };
        cargoDeps = prev.rustPlatform.fetchCargoTarball {
          inherit src;
          name = "joshuto-${version}-cargo-deps";
          hash = "sha256-gi/KKuhUIfiROHCPte2ii6M/Ld//UGiypWNb/c/iIL8=";
        };
        passthru.config = prev.runCommandLocal "joshuto-config" { } ''
          mkdir -p $out/share
          cp -r ${src}/config $out/share/
        '';
      };
    };

    ov = _final: prev: {
      ov = prev.ov.overrideAttrs {
        meta.mainProgram = "ov";
      };
    };
  };
}
