{
  flake.overlays = {
    joshuto = _final: prev: {
      joshuto = prev.joshuto.overrideAttrs (finalAttrs: {
        passthru.config = prev.runCommandLocal "joshuto-config" { } ''
          mkdir -p $out/share
          cp -r ${finalAttrs.src}/config $out/share/
        '';
      });
    };

    # Workaround to avoid build failures with bitwarden-cli
    # https://github.com/NixOS/nixpkgs/issues/339576#issuecomment-2574076670
    bitwarden-cli = _final: prev: {
      bitwarden-cli = prev.bitwarden-cli.overrideAttrs (oldAttrs: {
        nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ prev.llvmPackages_18.stdenv.cc ];
        inherit (prev.llvmPackages_18) stdenv;
      });
    };

    dotfiles = final: prev: {
      dotfiles = {
      };
    };
  };
}
