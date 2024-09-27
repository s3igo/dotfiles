{
  pkgs,
  mkApp,
  nix-darwin',
}:

let
  inherit (pkgs) lib writeShellApplication;
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
  install-skk-dicts = writeShellApplication {
    name = "install-skk-dicts";
    text =
      let
        skk-dict = pkgs.callPackage ./packages/skk-dict.nix { };
        cmd = jisyo: "cp ${skk-dict}/share/${jisyo} ${target}/${jisyo}";
        cmds = map cmd jisyoList;
        script = lib.concatStringsSep "\n" cmds;
      in
      if pkgs.stdenv.isDarwin then script else null;
  };
  cleanup-skk-dicts = writeShellApplication {
    name = "cleanup-skk-dicts";
    text =
      let
        cmd = jisyo: "rm -f ${target}/${jisyo}";
        cmds = map cmd jisyoList;
        script = lib.concatStringsSep "\n" cmds;
      in
      if pkgs.stdenv.isDarwin then script else null;
  };
in

{
  deploy = mkApp { drv = deploy; };
  wipe-history = mkApp { drv = wipe-history; };
  versions = mkApp { drv = versions; };
  install-skk-dicts = mkApp { drv = install-skk-dicts; };
  cleanup-skk-dicts = mkApp { drv = cleanup-skk-dicts; };
}
