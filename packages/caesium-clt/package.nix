{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "caesium-clt";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "Lymphatus";
    repo = "caesium-clt";
    tag = "v${finalAttrs.version}";
    hash = "sha256-e/RbgpZuSRFzTpS6PLLjqpVVt7WOcbDQD2jE3EiWhDE=";
  };

  cargoHash = "sha256-GYtU6UDdXJA2mjrL3pD7ZnbLwRioOuZ+l+OG9B15qFo=";

  meta = {
    description = "Caesium Command Line Tools - Lossy/lossless image compression tool";
    homepage = "https://github.com/Lymphatus/caesium-clt";
    changelog = "https://github.com/Lymphatus/caesium-clt/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = [ ];
    mainProgram = "caesiumclt";
  };
})
