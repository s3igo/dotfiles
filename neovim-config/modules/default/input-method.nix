_:

{ pkgs, ... }:

let
  inherit (pkgs)
    lib
    stdenv
    stdenvNoCC
    system
    vimUtils
    fetchFromGitHub
    ;
in

{
  extraPlugins = lib.optional stdenv.isDarwin (
    vimUtils.buildVimPlugin {
      pname = "im-select-nvim";
      version = "2024-07-21";
      src = fetchFromGitHub {
        owner = "keaising";
        repo = "im-select.nvim";
        rev = "6425bea7bbacbdde71538b6d9580c1f7b0a5a010";
        hash = "sha256-sE3ybP3Y+NcdUQWjaqpWSDRacUVbRkeV/fGYdPIjIqg=";
      };
    }
  );

  extraPackages = lib.optional stdenv.isDarwin (
    stdenvNoCC.mkDerivation {
      pname = "im-select";
      version = "2023-07-10";

      src = fetchFromGitHub {
        owner = "daipeihust";
        repo = "im-select";
        rev = "9cd5278b185a9d6daa12ba35471ec2cc1a2e3012";
        hash = "sha256-NQakn0Xa177Efx6G6eaKL+wHdNh+k30SN0618nV69b4=";
      };

      installPhase =
        let
          arch = if system == "aarch64-darwin" then "apple" else "intel";
        in
        ''
          mkdir -p $out/bin
          cp $src/macOS/out/${arch}/im-select $out/bin/
        '';
    }
  );

  extraConfigLua = lib.strings.optionalString stdenv.isDarwin ''
    -- im-select
    require('im_select').setup({ default_im_select = "net.mtgto.inputmethod.macSKK.ascii" })
  '';
}
