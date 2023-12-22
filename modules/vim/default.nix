{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.vim_configurable.customize {
      name = "vim";
      vimrcConfig.customRC = "source ${./vimrc.vim}";
    })
  ];
}
