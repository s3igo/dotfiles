{
  perSystem =
    { lib, pkgs, ... }:

    let
      # lib.packagesFromDirectoryRecursiveから、
      # 1. callPackageとnewScopeを受け取る機能を除き
      # 2. package.nixを除く.nixファイルをパッケージ化しないように
      # シンプル化した関数
      packagesFromDirs =
        directory:
        let
          defaultPath = directory + "/package.nix";
        in
        # package.nixがあればそれを返して終了
        if builtins.pathExists defaultPath then
          pkgs.callPackage defaultPath { }
        else
          # なければディレクトリ内容を処理
          let
            entries = builtins.readDir directory;
          in
          lib.concatMapAttrs (
            name: type:
            let
              path = directory + "/${name}";
            in
            if type == "directory" then
              # サブディレクトリは再帰処理
              { ${name} = packagesFromDirs path; }
            else
              # 通常のファイルは無視
              { }
          ) entries;

      isNested = _: v: builtins.isAttrs v && !lib.isDerivation v;
      allPackages = packagesFromDirs ./.;
    in

    rec {
      legacyPackages = lib.filterAttrs isNested allPackages;
      packages = builtins.removeAttrs allPackages (builtins.attrNames legacyPackages);
    };

}
