{
  user,
  inputs,
  ...
}:

{
  imports = [ inputs.home-manager.darwinModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit user;
      inherit (inputs) self;
    };
    users.${user} = import ../../home;
  };
}
