{ self, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      checks = {
        typos-check =
          pkgs.runCommandLocal "typos-check"
            {
              buildInputs = [ pkgs.typos ];
            }
            ''
              typos ${self}
              touch $out
            '';
      };
    };
}
