{ runCommand, fetchFromGitHub }:

runCommand "rio-themes"
  {
    src = fetchFromGitHub {
      owner = "raphamorim";
      repo = "rio-terminal-themes";
      rev = "d164b8c4a11e66a496235968fa806c8478caeedf";
      hash = "sha256-TElq6CmP31FmRAWCVLdv305kUOMZXvjYL5HFE5YTTgQ=";
    };
  }
  ''
    mkdir -p $out/share
    cp -r $src/themes $out/share/
  ''
