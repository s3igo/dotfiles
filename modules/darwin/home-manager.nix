{ self, user, ... }:

{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit self user;
    };
    users.${user} = import ../../home;
  };
}
