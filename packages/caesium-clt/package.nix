{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "caesium-clt";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "Lymphatus";
    repo = "caesium-clt";
    tag = "v${finalAttrs.version}";
    hash = "sha256-WHEihEKULw2S20Pcz2n67sPhNn7cRB/YkF7LzQf/YKE=";
  };

  cargoHash = "sha256-BYmvEokySY0L+ybeKpbA3rw7Wjt7/7ZRD2TKY1a6i1c=";

  meta = {
    description = "Caesium Command Line Tools - Lossy/lossless image compression tool";
    homepage = "https://github.com/Lymphatus/caesium-clt";
    changelog = "https://github.com/Lymphatus/caesium-clt/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = [ ];
    mainProgram = "caesiumclt";
  };
})
