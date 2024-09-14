{
  self,
  user,
  home-manager,
  ...
}:

{
  imports = [ home-manager.darwinModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit self user;
    };
    users.${user} = import ../../home;
  };
}
