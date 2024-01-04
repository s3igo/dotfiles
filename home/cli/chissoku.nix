{pkgs}:
pkgs.buildGoModule rec {
  pname = "chissoku";
  version = "2.0.2";

  src = pkgs.fetchFromGitHub {
    owner = "northeye";
    repo = "chissoku";
    rev = "v${version}";
    hash = "sha256-h5fSbhk9J5VOdE8/tMlYA3efkItssDNhmwa+2isRuWs=";
  };

  vendorHash = "sha256-CmYv5AWRR+zllvxl4olBqfmB9B8X7QSgF9fHMnU6kaU=";

  ldflags = ["-s" "-w"];
}
