{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "gogcli";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "steipete";
    repo = "gogcli";
    tag = "v${finalAttrs.version}";
    hash = "sha256-DXRw5jf/5fC8rgwLIy5m9qkxy3zQNrUpVG5C0RV7zKM=";
  };

  vendorHash = "sha256-nig3GI7eM1XRtIoAh1qH+9PxPPGynl01dCZ2ppyhmzU=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/steipete/gogcli/internal/cmd.version=${finalAttrs.src.tag}"
    "-X=github.com/steipete/gogcli/internal/cmd.commit=${finalAttrs.src.rev}"
    "-X=github.com/steipete/gogcli/internal/cmd.date=1970-01-01T00:00:00Z"
  ];

  doCheck = false; # ネットワーク接続が必要になるため

  meta = {
    description = "Google Suite CLI: Gmail, GCal, GDrive, GContacts";
    homepage = "https://github.com/steipete/gogcli";
    changelog = "https://github.com/steipete/gogcli/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = [ ];
    mainProgram = "gog";
  };
})
