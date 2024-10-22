{
  pkgs,
  nix-darwin',
}:

let
  inherit (pkgs) lib writeShellApplication;
  clone = writeShellApplication {
    name = "clone";
    runtimeInputs = [ pkgs.git ];
    text = ''
      git clone https://github.com/s3igo/dotfiles.git ~/.dotfiles
    '';
  };
  deploy = writeShellApplication {
    name = "deploy";
    runtimeInputs = [ nix-darwin' ];
    text = ''
      darwin-rebuild switch --flake ".#$(scutil --get LocalHostName)"
    '';
  };
  wipe-history = writeShellApplication {
    name = "wipe-history";
    text = ''
      sudo nix profile wipe-history --profile /nix/var/nix/profiles/system
      nix profile wipe-history --profile "$XDG_STATE_HOME/nix/profiles/home-manager"
    '';
  };
  versions = writeShellApplication {
    name = "versions";
    runtimeInputs = [ pkgs.gawk ];
    text = ''
      nix profile diff-closures --profile /nix/var/nix/profiles/system \
        | awk 'BEGIN { RS="" } { par=$0 } END { print par }'
    '';
  };
  target = "~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries";
  jisyoList = [
    "SKK-JISYO.L"
    "SKK-JISYO.jinmei"
    "SKK-JISYO.fullname"
    "SKK-JISYO.geo"
    "SKK-JISYO.propernoun"
    "SKK-JISYO.station"
    "SKK-JISYO.assoc"
    "SKK-JISYO.edict"
    # "SKK-JISYO.edict2" # occurs error
    "SKK-JISYO.zipcode"
    "SKK-JISYO.office.zipcode"
    "SKK-JISYO.JIS2"
    # "SKK-JISYO.JIS3_4" # occurs error
    "SKK-JISYO.JIS2004"
    "SKK-JISYO.itaiji"
    "SKK-JISYO.itaiji.JIS3_4"
    "SKK-JISYO.mazegaki"
  ];
  skk-dict = pkgs.callPackage ./packages/skk-dict.nix { };
  install-skk-dicts = writeShellApplication {
    name = "install-skk-dicts";
    text =
      let
        cmd = jisyo: "cp ${skk-dict}/share/${jisyo} ${target}/${jisyo}";
        cmds = map cmd jisyoList;
        script = lib.concatStringsSep "\n" cmds;
      in
      if pkgs.stdenv.isDarwin then script else null;
  };
  cleanup-skk-dicts = writeShellApplication {
    name = "cleanup-skk-dicts";
    text =
      if pkgs.stdenv.isDarwin then
        ''
          while read -r jisyo; do
            rm -f ${target}/"$jisyo"
          done < ${skk-dict.passthru.list}/share/dicts.txt
        ''
      else
        null;
  };
in

{
  clone = {
    type = "app";
    program = "${clone}/bin/clone";
  };
  deploy = {
    type = "app";
    program = "${deploy}/bin/deploy";
  };
  wipe-history = {
    type = "app";
    program = "${wipe-history}/bin/wipe-history";
  };
  versions = {
    type = "app";
    program = "${versions}/bin/versions";
  };
  install-skk-dicts = {
    type = "app";
    program = "${install-skk-dicts}/bin/install-skk-dicts";
  };
  cleanup-skk-dicts = {
    type = "app";
    program = "${cleanup-skk-dicts}/bin/cleanup-skk-dicts";
  };
}
