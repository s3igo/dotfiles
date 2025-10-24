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

      isNested = v: builtins.isAttrs v && !lib.isDerivation v;
      allPackages = packagesFromDirs ./.;
      partitioned = lib.foldlAttrs (
        acc: name: value:
        lib.recursiveUpdate acc (
          lib.setAttrByPath [
            (if isNested value then "legacyPackages" else "packages")
            name
          ] value
        )
      ) { } allPackages;
    in

    {
      inherit (partitioned) legacyPackages packages;
    };

}
