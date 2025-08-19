{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "caesium-clt";
  version = "1.0.0-beta.2";

  src = fetchFromGitHub {
    owner = "Lymphatus";
    repo = "caesium-clt";
    tag = "v${finalAttrs.version}";
    hash = "sha256-bmW2pXaSK98rdDm30CKlG046dD8R11Cric4ZBmjuKn8=";
  };

  cargoHash = "sha256-4heQvb434ePSpQDLq9GFzD8R3j3E90PDTzz0GVNtM2U=";

  meta = {
    description = "Caesium Command Line Tools - Lossy/lossless image compression tool";
    homepage = "https://github.com/Lymphatus/caesium-clt";
    changelog = "https://github.com/Lymphatus/caesium-clt/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = [ ];
    mainProgram = "caesiumclt";
  };
})
