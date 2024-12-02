{
  perSystem =
    {
      pkgs,
      self',
      ...
    }:

    let
      target = "~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries";
      inherit (self'.packages) skk-dict;
    in

    {
      mission-control.scripts = {
        install-skk-dicts = {
          description = "Install SKK dictionaries";
          category = "IME";
          exec =
            let
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
              cmd = jisyo: "cp ${skk-dict}/share/${jisyo} ${target}/${jisyo}";
              cmds = map cmd jisyoList;
              script = builtins.concatStringsSep "\n" cmds;
            in
            if pkgs.stdenv.isDarwin then script else null;
        };

        cleanup-skk-dicts = {
          description = "Remove installed SKK dictionaries";
          category = "IME";
          exec =
            let
              cmd = jisyo: "rm -f ${target}/${jisyo}";
              cmds = map cmd skk-dict.passthru.list;
              script = builtins.concatStringsSep "\n" cmds;
            in
            if pkgs.stdenv.isDarwin then script else null;
        };
      };
    };
}
