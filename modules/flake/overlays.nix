{
  flake.overlays = {
    joshuto = _final: prev: {
      joshuto = prev.joshuto.overrideAttrs rec {
        version = "0.9.8-unstable-2024-09-28";
        src = prev.fetchFromGitHub {
          owner = "kamiyaa";
          repo = "joshuto";
          rev = "7712c07077975ce63038d61afff42c262a17fd21";
          hash = "sha256-H0sknoaeiomAPP8DMyg1duV37lDsHd2xYnEWMyLUQCs=";
        };
        cargoDeps = prev.rustPlatform.fetchCargoTarball {
          inherit src;
          name = "joshuto-${version}-cargo-deps";
          hash = "sha256-xkECaxyXSQtUr1b3Xnv061sCaGVgUxAbQ8y32VZXQe0=";
        };
        passthru.config = prev.runCommandLocal "joshuto-config" { } ''
          mkdir -p $out/share
          cp -r ${src}/config $out/share/
        '';
      };
    };

    tdf = _final: prev: {
      tdf = prev.tdf.overrideAttrs {
        meta.platforms = prev.lib.platforms.unix;
      };
    };

    ov = _final: prev: {
      ov = prev.ov.overrideAttrs {
        meta.mainProgram = "ov";
      };
    };

    gh-copilot = _final: prev: {
      gh-copilot = prev.gh-copilot.overrideAttrs rec {
        version = "1.0.5";
        src = prev.fetchurl {
          name = "gh-copilot";
          url = "https://github.com/github/gh-copilot/releases/download/v${version}/darwin-arm64";
          hash = "sha256-qVsItCI3LxPraOLtEvVaoTzhoGEcIySTWooMBSMLvAc=";
        };
        meta.platforms = [ "aarch64-darwin" ];
      };
    };
  };
}
