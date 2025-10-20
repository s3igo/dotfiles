{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "caesium-clt";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "Lymphatus";
    repo = "caesium-clt";
    tag = "v${finalAttrs.version}";
    hash = "sha256-La+0KuZ7kLpivDR1CNb6yTtQqxgAdCI4osBt3N35LGk=";
  };

  cargoHash = "sha256-xWshZZO/7N89nfu9YDeBTGgd98Jtlw31HSQRlfBCsFY=";

  meta = {
    description = "Caesium Command Line Tools - Lossy/lossless image compression tool";
    homepage = "https://github.com/Lymphatus/caesium-clt";
    changelog = "https://github.com/Lymphatus/caesium-clt/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = [ ];
    mainProgram = "caesiumclt";
  };
})
