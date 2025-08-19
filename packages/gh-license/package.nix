{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "gh-license";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "Shresht7";
    repo = "gh-license";
    tag = "v${finalAttrs.version}";
    hash = "sha256-HjvoSi5AP2vrEZhHxOTwxntY6U8qoNkMRn3YNTlHN6g=";
  };

  vendorHash = "sha256-6bzOZ5KYtP99uylIssp9voxhuvIpudKZF5irKuGZ0FI=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "A GitHub CLI extension to view and generate license files";
    homepage = "https://github.com/Shresht7/gh-license";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "gh-license";
  };
})
