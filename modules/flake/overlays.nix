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
        cargoDeps = prev.rustPlatform.fetchCargoVendor {
          inherit src;
          name = "joshuto-${version}-cargo-deps";
          hash = "sha256-4B9K6ajmL+WvuRAgf7AsTHNiBroq1t8WW7r4n3H1OQQ=";
        };
        passthru.config = prev.runCommandLocal "joshuto-config" { } ''
          mkdir -p $out/share
          cp -r ${src}/config $out/share/
        '';
      };
    };

    # Workaround to avoid build failures with bitwarden-cli
    # https://github.com/NixOS/nixpkgs/issues/339576#issuecomment-2574076670
    bitwarden-cli = _final: prev: {
      bitwarden-cli = prev.bitwarden-cli.overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ prev.llvmPackages_18.stdenv.cc ];
        inherit (prev.llvmPackages_18) stdenv;
      });
    };
  };
}
