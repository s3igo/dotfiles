{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
}:

rustPlatform.buildRustPackage rec {
  pname = "caesium-clt";
  version = "1.0.0-beta.0";

  src = fetchFromGitHub {
    owner = "Lymphatus";
    repo = "caesium-clt";
    rev = "v${version}";
    hash = "sha256-wdmlUpTL6UFGEDbmE/Ck1PAtB3xKP9hoLvxXk+2Q6pQ=";
  };

  cargoHash = "sha256-D0rTkIktRSrCX4MtUZWOFCZkxM9McyWJnQyO3R7/cqo=";

  nativeBuildInputs = [
    pkg-config
  ];

  meta = {
    description = "Caesium Command Line Tools - Lossy/lossless image compression tool";
    homepage = "https://github.com/Lymphatus/caesium-clt";
    changelog = "https://github.com/Lymphatus/caesium-clt/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = [ ];
    mainProgram = "caesiumclt";
  };
}
