{
  lib,
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "pending-mono-hwnf";
  version = "0.0.3";

  src = fetchzip {
    url = "https://github.com/yuru7/pending-mono/releases/download/v${version}/PendingMonoHWNF_v${version}.zip";
    hash = "sha256-GgT+qXMhK+FmMKAlTtNB2nWkGIe/JpBlX898MDSISHg=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm644 *.ttf -t $out/share/fonts/pending-mono-hwnf

    runHook postInstall
  '';

  meta = with lib; {
    description = "Programming font with a half-width to full-width ratio of 1:2, created by combining Commit Mono, BIZ UD Gothic, and nerd-fonts";
    homepage = "https://github.com/yuru7/pending-mono";
    license = licenses.ofl;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
