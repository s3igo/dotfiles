{ pkgs, ... }:

{
  extraPlugins = with pkgs; [
    (vimUtils.buildVimPlugin {
      pname = "im-select-nvim";
      version = "2024-01-28";
      src = fetchFromGitHub {
        owner = "keaising";
        repo = "im-select.nvim";
        rev = "ca1aebb8f5c8a0342ae99a0fcc8ebc49b5f2201e";
        hash = "sha256-tyVGbfRoshuuUWkFlQa6YvoJJ4HMLmG5p8Y0EsP1Zig=";
      };
    })
  ];

  extraConfigLua = ''
    -- im-select
    require('im_select').setup({ set_previous_events = {} })
  '';
}
