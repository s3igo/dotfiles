{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "chissoku";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "northeye";
    repo = "chissoku";
    rev = "v${version}";
    hash = "sha256-47/5PkEBj/hfEVjKWRcIKKrQLVEAygA1DYRsJB11IGk=";
  };

  vendorHash = "sha256-CmYv5AWRR+zllvxl4olBqfmB9B8X7QSgF9fHMnU6kaU=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "A CO2 Sensor (IO-DATA UD-CO2S) Reader using USB serial";
    homepage = "https://github.com/northeye/chissoku";
    changelog = "https://github.com/northeye/chissoku/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "chissoku";
  };
}
