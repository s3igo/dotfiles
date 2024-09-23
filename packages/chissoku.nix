{
  buildGoModule,
  fetchurl,
}:

buildGoModule rec {
  pname = "chissoku";
  version = "v2.1.1";

  src = fetchurl {
    url = "https://github.com/northeye/chissoku/archive/refs/tags/${version}.tar.gz";
    sha256 = "sha256-O2QZZJLBqKrY5ctcIW7RX6ZIgMg3jL6pp7vLhhfMv1k=";
  };

  vendorHash = "sha256-CmYv5AWRR+zllvxl4olBqfmB9B8X7QSgF9fHMnU6kaU=";
}
