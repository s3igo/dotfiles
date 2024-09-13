{
  rustPlatform,
  fetchurl,
  lib,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "yaskkserv2";
  version = "0.1.7";

  src = fetchurl {
    url = "https://github.com/wachikun/yaskkserv2/archive/refs/tags/${version}.tar.gz";
    sha256 = "sha256-k4Mc0yzWC/lG+/75iLhcKIEFE0qaOsRs+C8OGLq9HUs=";
  };

  cargoHash = "sha256-vNpaCcGYKgSJuqYLDQEwTT2Vq6eVkXnXM6lhSUU2RtU=";
  buildInputs = lib.optional stdenv.isDarwin darwin.apple_sdk.frameworks.Security;
  doCheck = false;
}
