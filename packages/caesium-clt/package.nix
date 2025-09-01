{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "caesium-clt";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "Lymphatus";
    repo = "caesium-clt";
    tag = "v${finalAttrs.version}";
    hash = "sha256-tf91RqrXy4naUrWbh4fEB5Tm6oFDbEyPuLMwC1NJFKE=";
  };

  cargoHash = "sha256-DsEBY1g3/lFaiDum5ySYAKBxVg7MQk7+qlXVsx8+lBA=";

  meta = {
    description = "Caesium Command Line Tools - Lossy/lossless image compression tool";
    homepage = "https://github.com/Lymphatus/caesium-clt";
    changelog = "https://github.com/Lymphatus/caesium-clt/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = [ ];
    mainProgram = "caesiumclt";
  };
})
