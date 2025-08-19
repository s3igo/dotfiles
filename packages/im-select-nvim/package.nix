{
  lib,
  vimUtils,
  fetchFromGitHub,
}:

vimUtils.buildVimPlugin {
  pname = "im-select-nvim";
  version = "2024-12-12";

  src = fetchFromGitHub {
    owner = "keaising";
    repo = "im-select.nvim";
    rev = "630b4bfe1c71ca9947b2b437a52c0f60cc55208c";
    hash = "sha256-2AXmoLYcJPMczB8rQSS3taDUejf4Zix9/hi7szPwHy0=";
  };

  meta = {
    description = "Switch Input Method automatically depends on Neovim's edit mode";
    homepage = "https://github.com/keaising/im-select.nvim";
    license = lib.licenses.mit;
    maintainers = [ ];
  };
}
